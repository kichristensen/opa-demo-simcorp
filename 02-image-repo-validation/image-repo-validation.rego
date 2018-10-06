package kubernetes.admission

deny[msg] {
    input.request.kind.kind = "Pod"
    container = input.request.object.spec.containers[_]
    not re_match("^simcorp.azurecr.io/.+$", container.image)
    msg = sprintf("container %q doesn't use image from simcorp.azurecr.io", [container.name])
}