package dal

import (
	"context"

	"github.com/aisstream/ais-message-models/golang/aisStream"
	"github.com/henvic/pgq"
)

// InsertPositionReport inserts a position report into the database.
func (arw *aisReadWriter) InsertPositionReport(ctx context.Context, pr *aisStream.PositionReport) error {
	q := pgq.Insert("position_report").
		Columns(
			"message_id",
			"repeat_indicator",
			"user_id",
			"valid",
			"navigational_status",
			"rate_of_turn",
			"sog",
			"position_accuracy",
			"longitude",
			"latitude",
			"cog",
			"true_heading",
			"timestamp",
			"special_manoeuvre_indicator",
			"spare",
			"raim",
			"communication_state",
		).
		Values(
			pr.MessageID,
			pr.RepeatIndicator,
			pr.UserID,
			pr.Valid,
			pr.NavigationalStatus,
			pr.RateOfTurn,
			pr.Sog,
			pr.PositionAccuracy,
			pr.Longitude,
			pr.Latitude,
			pr.Cog,
			pr.TrueHeading,
			pr.Timestamp,
			pr.SpecialManoeuvreIndicator,
			pr.Spare,
			pr.Raim,
			pr.CommunicationState,
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
