package main

import (
	"github.com/acernik/ais-etl/internal/client"
	"github.com/acernik/ais-etl/internal/config"
	"github.com/acernik/ais-etl/internal/worker"
	"github.com/gorilla/websocket"
	"log"
)

func main() {
	if err := run(); err != nil {
		panic(err)
	}
}

func run() error {
	cfg, err := config.New()
	if err != nil {
		log.Printf("config.New() error: %v", err)
		return err
	}

	ws, _, err := websocket.DefaultDialer.Dial(cfg.WssURL, nil)
	if err != nil {
		log.Printf("DefaultDialer error: %v", err)
		return err
	}

	cl := client.New(ws)
	defer cl.Close()

	boundingBoxes := [][][]float64{{
		{
			cfg.UpperLeftCorner.Latitude,
			cfg.UpperLeftCorner.Longitude,
		},
		{
			cfg.LowerRightCorner.Latitude,
			cfg.LowerRightCorner.Longitude,
		},
	}}

	wrk := worker.New(cl, cfg.APIKey, boundingBoxes)
	err = wrk.DoWork()
	if err != nil {
		log.Printf("DoWork error: %v", err)
		return err
	}

	return nil
}
