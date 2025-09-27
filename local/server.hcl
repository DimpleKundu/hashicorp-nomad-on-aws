server {
  enabled          = true
  bootstrap_expect = 1
}

# Enable ACLs for security
acl {
  enabled = true
}

bind_addr = "0.0.0.0"
datacenter = "dc1"
data_dir   = "/tmp/nomad-server"

ui {
  enabled = true
}
