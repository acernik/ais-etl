package config

import (
	"github.com/kelseyhightower/envconfig"
)

const aisEtl = "aisetl"

// Config is the configuration for the application.
type Config struct {
	Name            string `default:"ais-etl"`
	WssURL          string `default:"wss://stream.aisstream.io/v0/stream"`
	APIKey          string
	UpperLeftCorner struct {
		Latitude  float64 `default:"36.147079"`
		Longitude float64 `default:"-35.991341"`
	}
	LowerRightCorner struct {
		Latitude  float64 `default:"77.807236"`
		Longitude float64 `default:"16.008856"`
	}
}

// New returns a new value of type Config.
func New() (*Config, error) {
	var c Config
	err := envconfig.Process(aisEtl, &c)
	if err != nil {
		return nil, err
	}

	return &c, nil
}
