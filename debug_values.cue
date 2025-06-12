@if(debug)

package main

// Values used by debug_tool.cue.
// Debug example 'cue cmd -t debug -t name=test -t namespace=test -t mv=1.0.0 -t kv=1.28.0 build'.
values: {
	address: "http://localhost:8200"
	auth: {
		method: "kubernetes"
		mount: "kubernetes"
	}
	secret: {
		destination: {
			name: "test-secret"
		}
		path: "app/secret"
		type: "kv-v2"
		mount: "kv"
	}
}
