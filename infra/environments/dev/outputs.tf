output "server_ip" {
  value = module.nomad_server.server_ip
}

output "client_ip" {
  value = module.nomad_client.client_ip
}
