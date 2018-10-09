package kubernetes.admission

test_docker_hub_image_denied {
    deny[`container "dockerhub-image" doesn't use image from simcorp.azurecr.io`] with input as { "request": { "kind": { "kind": "Pod" }, "object": { "spec": { "containers": [ { "name": "dockerhub-image", "image": "busybox" } ] } } } }
}

test_simcorp_image_is_allowed {
    not deny[""] with input as { "request": { "kind": { "kind": "Pod" }, "object": { "spec": { "containers": [ { "name": "dockerhub-image", "image": "simcorp.azurecr.io/busybox" } ] } } } }
}