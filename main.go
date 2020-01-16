package main

import (
	"time"

	log "github.com/sirupsen/logrus"
)

func main() {
	log.SetFormatter(&log.TextFormatter{
		DisableColors: false,
		FullTimestamp: true,
	})
	for {
		log.Println("I am still running ....")
		time.Sleep(2 * time.Second)
	}
}
