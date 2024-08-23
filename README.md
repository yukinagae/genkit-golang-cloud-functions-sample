# genkit-golang-cloud-functions-sample

`genkit-golang-cloud-functions-sample` is a sample repository designed to help you learn how to build Large Language Model (LLM) applications using Firebase Genkit with Golang, deployed to Google Cloud Functions.

- [Requirements](#requirements)
- [Usage](#usage)
- [License](#license)

## Requirements

- **Go**: Follow the [Go - Download and install](https://go.dev/doc/install) to install Go.
- **Genkit**: Follow the [Firebase Genkit - Get started](https://firebase.google.com/docs/genkit/get-started) to install Genkit.
- **Google Cloud CLI (gcloud)**: Follow the [Google Cloud - Install the gcloud CLI](https://cloud.google.com/sdk/docs/install) to install gcloud.
- **Docker**: Follow the [Docker - Install Docker Engine](https://docs.docker.com/engine/install/) to install Docker.
- **Pack**: Follow the [Buildpacks.io - Pack](https://buildpacks.io/docs/for-platform-operators/how-to/integrate-ci/pack/) to install Pack.

Verify your installations:

```bash
$ go version
v22.4.1
$ genkit --version
0.5.4
$ gcloud --version
Google Cloud SDK 489.0.0
alpha 2024.08.16
bq 2.1.8
core 2024.08.16
gcloud-crc32c 1.0.0
gsutil 5.30
$ docker --version
Docker version 20.10.20, build 9fdeb9c
$ docker ps # make sure docker is running
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
$ pack --version
0.35.1+git-3a22a7f.build-6099
```

## Usage

### Run Genkit

Set your API key and start Genkit:

```bash
$ export GOOGLE_GENAI_API_KEY=your_api_key
$ make genkit # Starts Genkit
```

Open your browser and navigate to [http://localhost:4000](http://localhost:4000) to access the Genkit UI.

### Run HTTP Server Locally

To start the local http server, run the following command:

```bash
$ make dev
```

To test the function, use the following curl command:

```bash
$ curl -X POST -H "Content-Type: application/json" \
-d '{"url":"https://firebase.blog/posts/2024/04/next-announcements/"}' http://localhost:8080
Firebase announces new updates, including vector search for Firestore, Vertex AI SDKs, and public preview of Gemini.
```

## Run Cloud Functions Emulator

**Note**: To enable alpha components, run the following command:

```bash
$ gcloud components install alpha
```

To run the emulator, set your secret values in `./.env.yaml`:

```bash
$ cp -p ./.env.example.yaml ./.env.yaml
$ vim ./.env.example.yaml # replace the secrets with your own values
GOOGLE_GENAI_API_KEY: your_api_key
```

To start the emulator, run the following command:

```bash
$ make start-emulator
```

To test the function on the emulator, use the following gcloud or curl command:

```bash
$ gcloud alpha functions local call summarize-function --data='{"url": "https://firebase.blog/posts/2024/04/next-announcements/"}'
# or
$ curl -X POST -H "Content-Type: application/json" \
-d '{"url":"https://firebase.blog/posts/2024/04/next-announcements/"}' http://localhost:8080
```

To remove the emulator, run the following command:

```bash
$ make remove-emulator
```

### Deploy

Follow these steps to deploy the function:

```bash
$ gcloud auth application-default login
$ gcloud config set core/project [your-project-id]
$ make deploy
```

**CAUTION**: This deployment uses `.env.yaml` for environment variables, including the API key. This is not recommended for production. Instead, use Google Cloud Secret Manager for better security.

To test the deployed function, use the following curl command:

```bash
$ curl -X POST -H "Content-Type: application/json" \
-d '{"url":"https://firebase.blog/posts/2024/04/next-announcements/"}' \
https://us-central1-[your-project-id].cloudfunctions.net/summarize-function
```

### Code Formatting

To ensure your code is properly formatted, run the following command:

```bash
$ make tidy
```

## License

MIT
