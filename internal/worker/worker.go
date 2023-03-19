package worker

import (
	"fmt"
	"log"

	aisstream "github.com/aisstream/ais-message-models/golang/aisStream"

	"github.com/acernik/ais-etl/internal/client"
)

// AISWorker is an interface for a worker that reads from the AISStream websocket and writes to a database.
type AISWorker interface {
	DoWork() error
}

// aisWorker is a struct that implements the AISWorker interface.
type aisWorker struct {
	aisClient     client.AISReadWriter
	apiKey        string
	boundingBoxes [][][]float64
}

// New returns a new value of type that implements AISWorker.
func New(ac client.AISReadWriter, apk string, bbs [][][]float64) AISWorker {
	return &aisWorker{
		aisClient:     ac,
		apiKey:        apk,
		boundingBoxes: bbs,
	}
}

// DoWork reads from the AISStream websocket and writes to a database.
func (a *aisWorker) DoWork() error {
	log.Printf("apiKey: %s", a.apiKey)
	log.Printf("boundingBoxes: %v", a.boundingBoxes)
	subMsg := aisstream.SubscriptionMessage{
		APIKey: a.apiKey,
		// https://gist.github.com/graydon/11198540
		BoundingBoxes: a.boundingBoxes, // bounding boxes for the Mayotte
	}

	err := a.aisClient.Write(subMsg)
	if err != nil {
		log.Printf("aisClient.Write error: %v", err)
		return err
	}

	for {
		pck, err := a.aisClient.Read()
		if err != nil {
			log.Printf("aisClient.Read error: %v", err)
			return err
		}

		var shipName string
		// field may or may not be populated
		if packetShipName, ok := pck.MetaData["ShipName"]; ok {
			shipName = packetShipName.(string)
		}

		switch pck.MessageType {
		case aisstream.POSITION_REPORT:
			var positionReport aisstream.PositionReport
			positionReport = *pck.Message.PositionReport
			fmt.Printf("MMSI: %d Ship Name: %s Latitude: %f Latitude: %f\n",
				positionReport.UserID, shipName, positionReport.Latitude, positionReport.Longitude)
		}

	}
}
