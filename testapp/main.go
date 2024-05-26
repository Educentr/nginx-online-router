package main

import (
	"fmt"
	"log"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Printf("Received request: %s %s\n", r.Method, r.URL.Path)

	fmt.Fprintf(w, "Hello, World!")
}

func main() {
	fmt.Printf("Start app")

	http.HandleFunc("/", handler)

	log.Fatal(http.ListenAndServe(":8200", nil))
}
