package main

import (
	"context"
	"log"
	"os"

	"github.com/gorilla/websocket"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/acernik/ais-etl/internal/client"
	"github.com/acernik/ais-etl/internal/config"
	"github.com/acernik/ais-etl/internal/dal"
	"github.com/acernik/ais-etl/internal/worker"
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

	dbPool, err := pgxpool.New(context.Background(), os.Getenv("DATABASE_URL"))
	if err != nil {
		log.Printf("Unable to create connection pool: %v\n", err)
		return err
	}

	aisDal := dal.New(dbPool)

	wrk := worker.New(cl, aisDal, cfg.APIKey, boundingBoxes)
	err = wrk.DoWork()
	if err != nil {
		log.Printf("DoWork error: %v", err)
		return err
	}

	return nil
}
