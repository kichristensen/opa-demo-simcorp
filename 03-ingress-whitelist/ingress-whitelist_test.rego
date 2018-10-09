package kubernetes.admission

test_invalid_host {
    deny[`invalid ingress host "google.com"`] with input as { "request": { "kind": { "kind": "Ingress" }, "operation": "CREATE", "namespace": "qa", "object": { "spec": { "rules": [ { "host": "google.com" } ] } } } }
}

test_valid_host {
    not deny[""] with input as { "request": { "kind": { "kind": "Ingress" }, "operation": "CREATE", "namespace": "qa", "object": { "spec": { "rules": [ { "host": "t.internal.acmecorp.com" } ] } } } }
}