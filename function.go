package function

import (
	"encoding/json"
	"fmt"
	"html"
	"net/http"

	"github.com/GoogleCloudPlatform/functions-framework-go/functions"
	"github.com/yukinagae/genkit-golang-cloud-functions-sample/flow"
)

func init() {
	functions.HTTP("SummarizeHTTP", SummarizeHTTP)
}

func SummarizeHTTP(w http.ResponseWriter, r *http.Request) {
	ctx := r.Context()

	var d struct {
		URL string `json:"url"`
	}
	if err := json.NewDecoder(r.Body).Decode(&d); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	f := flow.DefineFlow(ctx)
	answer, err := f.Run(ctx, d.URL)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	fmt.Fprintf(w, "%s", html.EscapeString(answer))
}
