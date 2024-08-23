package main

import (
	"context"
	"log"

	"github.com/firebase/genkit/go/genkit"
	"github.com/yukinagae/genkit-golang-cloud-functions-sample/flow"
)

func main() {
	ctx := context.Background()

	_ = flow.DefineFlow(ctx)

	// Initialize Genkit and start the Genkit GUI dev server
	if err := genkit.Init(ctx, nil); err != nil {
		log.Fatalf("Failed to initialize Genkit: %v", err)
	}
}
