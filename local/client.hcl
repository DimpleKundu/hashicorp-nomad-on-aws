client {
  enabled = true
  servers = ["127.0.0.1:4647"]  # server RPC port
  options {
    "driver.raw_exec.enable" = "1"
  }
}

plugin "docker" {
  config {
    allow_privileged = true
  }
}

bind_addr  = "0.0.0.0"
datacenter = "dc1"
data_dir   = "/tmp/nomad-client"

ports {
  http = 4649   # change client HTTP port to avoid conflict
}
