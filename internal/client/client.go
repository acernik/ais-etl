package client

import (
	"encoding/json"
	aisstream "github.com/aisstream/ais-message-models/golang/aisStream"
	"github.com/gorilla/websocket"
)

// AISReadWriter is an interface for reading from and writing to the AISStream websocket.
type AISReadWriter interface {
	Read() (packet *aisstream.AisStreamMessage, err error)
	Write(subMsg aisstream.SubscriptionMessage) error
	Close() error
}

// aisReadWriter is a struct that implements the AISReadWriter interface.
type aisReadWriter struct {
	ws *websocket.Conn
}

// New returns a new value of type that implements AISReadWriter.
func New(wss *websocket.Conn) AISReadWriter {
	return &aisReadWriter{
		ws: wss,
	}
}

// Read reads from the websocket and returns an AisStreamMessage.
func (a *aisReadWriter) Read() (packet *aisstream.AisStreamMessage, err error) {
	_, p, err := a.ws.ReadMessage()
	if err != nil {
		return nil, err
	}

	err = json.Unmarshal(p, &packet)
	if err != nil {
		return nil, err
	}

	return packet, nil
}

// Write writes a SubscriptionMessage to the websocket that specifies what data is to be expected from AIS.
func (a *aisReadWriter) Write(subMsg aisstream.SubscriptionMessage) error {
	subMsgBytes, err := json.Marshal(subMsg)
	if err != nil {
		return err
	}

	return a.ws.WriteMessage(websocket.TextMessage, subMsgBytes)
}

// Close closes the websocket.
func (a *aisReadWriter) Close() error {
	return a.ws.Close()
}
