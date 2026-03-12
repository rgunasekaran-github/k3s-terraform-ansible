  # Deny images using 'latest' tag
  deny[msg] {
      input.request.kind.kind == "Deployment"
      container := input.request.object.spec.template.spec.containers[_]
      endswith(container.image, ":latest")
      msg := sprintf("Container '%s' cannot use 'latest' tag", [container.name])
  }

  # Deny images without tags
  deny[msg] {
      input.request.kind.kind == "Deployment"
      container := input.request.object.spec.template.spec.containers[_]
      not contains(container.image, ":")
      msg := sprintf("Container '%s' must specify an image tag", [container.name])
  }

  # Require approved registries (RTL example)
  deny[msg] {
      input.request.kind.kind == "Deployment"
      container := input.request.object.spec.template.spec.containers[_]
      not startswith(container.image, "rtlacr.azurecr.io/")
      not startswith(container.image, "ghcr.io/")
      not startswith(container.image, "docker.io/library/")
      msg := sprintf("Container '%s' must use approved registry (rtlacr.azurecr.io, ghcr.io, or docker.io/library)", [container.name])
  }