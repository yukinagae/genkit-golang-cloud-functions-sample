# Default target: print this help message
.PHONY: help
.DEFAULT_GOAL := help
help:
	@echo 'Usage:'
	@echo '  make <target>'
	@echo ''
	@echo 'Targets:'
	@sed -n 's/^##//p' $(MAKEFILE_LIST) | column -t -s ':' | sed -e 's/^/  /'

## genkit: Run Genkit locally
.PHONY: genkit
genkit:
	cd genkit && genkit start

## dev: Run http server locally
.PHONY: dev
dev:
	export FUNCTION_TARGET=SummarizeHTTP && go run cmd/main.go

## start-emulator: Run Cloud Functions emulator locally
.PHONY: start-emulator
start-emulator:
	gcloud alpha functions local deploy summarize-function \
		--runtime=go122 \
		--source=. \
		--env-vars-file=.env.yaml \
		--entry-point=SummarizeHTTP

## remove-emulator: Remove Cloud Functions emulator locally
.PHONY: remove-emulator
remove-emulator:
	gcloud alpha functions local delete summarize-function

## deploy: Deploy Cloud Functions
.PHONY: deploy
deploy:
	gcloud functions deploy summarize-function \
		--gen2 \
		--runtime=go122 \
		--region=us-central1 \
		--source=. \
		--env-vars-file=.env.yaml \
		--entry-point=SummarizeHTTP \
		--trigger-http \
		--allow-unauthenticated

## tidy: Tidy modfiles and format .go files
.PHONY: tidy
tidy:
	go mod tidy -v
	go fmt ./...
