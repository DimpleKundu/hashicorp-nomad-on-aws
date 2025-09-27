job "hello" {
  datacenters = ["dc1"]

  group "example" {
    count = 1

    task "web" {
      driver = "docker"

      config {
        image = "hashicorp/http-echo"
        args  = ["-text=Hello, Nomad!"]
        port_map {
          http = 5678
        }
      }

      resources {
        network {
          mbits = 10
          port "http" {}
        }
      }
    }
  }
}
