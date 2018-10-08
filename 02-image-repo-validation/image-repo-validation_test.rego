package kubernetes.admission

test_docker_hub_image_denied {
    deny[msg] with input as { "request": { "kind": { "kind": "Pod" }, "object": { "spec": { "containers": [ { "name": "dockerhub-image", "image": "busybox" } ] } } } }
}

test_simcorp_image_is_allowed {
    msg := ""
    not deny[msg] with input as { "request": { "kind": { "kind": "Pod" }, "object": { "spec": { "containers": [ { "name": "dockerhub-image", "image": "simcorp.azurecr.io/busybox" } ] } } } }
}