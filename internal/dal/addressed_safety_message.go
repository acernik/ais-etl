package dal

import (
	"context"

	"github.com/aisstream/ais-message-models/golang/aisStream"
	"github.com/henvic/pgq"
)

// InsertAddressedSafetyMessage inserts an addressed safety message into the database.
func (arw *aisReadWriter) InsertAddressedSafetyMessage(ctx context.Context, asm *aisStream.AddressedSafetyMessage) error {
	q := pgq.Insert("addressed_safety_message").
		Columns(
			"message_id",
			"repeat_indicator",
			"user_id",
			"valid",
			"sequenceinteger",
			"destination_id",
			"retransmission",
			"spare",
			"text",
		).
		Values(
			asm.MessageID,
			asm.RepeatIndicator,
			asm.UserID,
			asm.Valid,
			asm.Sequenceinteger,
			asm.DestinationID,
			asm.Retransmission,
			asm.Spare,
			asm.Text,
		)

	sql, args, err := q.SQL()
	if err != nil {
		return err
	}

	_, err = arw.dbPool.Exec(ctx, sql, args...)
	if err != nil {
		return err
	}

	return nil
}
