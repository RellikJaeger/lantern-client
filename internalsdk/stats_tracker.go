package internalsdk

import (
	"github.com/getlantern/flashlight/stats"
)

type statsTracker struct {
	stats.Tracker
	session panickingSession
}

func NewStatsTracker(session panickingSession) *statsTracker {
	s := &statsTracker{
		Tracker: stats.NewTracker(),
		session: session,
	}
	s.Tracker.AddListener(func(st stats.Stats) {
		s.session.UpdateStats(st.City, st.Country,
			st.CountryCode, st.HTTPSUpgrades, st.AdsBlocked)
	})
	return s
}
