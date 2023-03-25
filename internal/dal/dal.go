package dal

import (
	"context"

	"github.com/aisstream/ais-message-models/golang/aisStream"
	"github.com/jackc/pgx/v5/pgxpool"
)

// AISReadWriter is the interface for the AIS DAL.
type AISReadWriter interface {
	InsertPositionReport(ctx context.Context, pr *aisStream.PositionReport) error
	InsertAddressedSafetyMessage(ctx context.Context, asm *aisStream.AddressedSafetyMessage) error
}

// aisReadWriter is the value of type that implements AISReadWriter.
type aisReadWriter struct {
	dbPool *pgxpool.Pool
}

// New returns a new value of type that implements AISReadWriter.
func New(dbp *pgxpool.Pool) AISReadWriter {
	return &aisReadWriter{
		dbPool: dbp,
	}
}
