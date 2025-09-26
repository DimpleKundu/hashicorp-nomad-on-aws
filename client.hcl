client {
  enabled = true
  options {
    "driver.raw_exec.enable" = "1"
    "docker.auth_config" = "{}"
  }
}

plugin "docker" {
  config {
    allow_privileged = true
  }
}
