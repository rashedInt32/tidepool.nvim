// Tidepool demo: Go
package main

import (
	"context"
	"errors"
	"fmt"
	"sync"
	"time"
)

const maxHeight = 4.2

var ErrOutOfRange = errors.New("height out of range")

type Phase int

const (
	Rising Phase = iota
	Falling
)

func (p Phase) String() string {
	return [...]string{"rising", "falling"}[p]
}

type Reading struct {
	Station string  `json:"station"`
	Height  float64 `json:"height"`
}

type Source interface {
	Read(ctx context.Context, station string) (Reading, error)
}

type fakeSource struct{ delay time.Duration }

func (f fakeSource) Read(ctx context.Context, station string) (Reading, error) {
	select {
	case <-ctx.Done():
		return Reading{}, ctx.Err()
	case <-time.After(f.delay):
		return Reading{Station: station, Height: float64(len(station)) * 0.8}, nil
	}
}

func collect(ctx context.Context, src Source, stations []string) ([]Reading, error) {
	var (
		mu  sync.Mutex
		wg  sync.WaitGroup
		out = make([]Reading, 0, len(stations))
	)
	for _, s := range stations {
		wg.Add(1)
		go func(station string) {
			defer wg.Done()
			r, err := src.Read(ctx, station)
			if err != nil || r.Height > maxHeight {
				return // TODO: report ErrOutOfRange
			}
			mu.Lock()
			out = append(out, r)
			mu.Unlock()
		}(s)
	}
	wg.Wait()
	return out, nil
}

func main() {
	ctx, cancel := context.WithTimeout(context.Background(), 500*time.Millisecond)
	defer cancel()

	readings, err := collect(ctx, fakeSource{delay: 10 * time.Millisecond}, []string{"north", "south"})
	if err != nil {
		panic(err)
	}
	for i, r := range readings {
		fmt.Printf("%d: %-6s %.2fm\n", i, r.Station, r.Height)
	}
}
