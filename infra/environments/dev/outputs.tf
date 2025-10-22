# Outputs 
output "server_public_ip" {
  description = "Nomad Server Public IP"
  value       = module.nomad_server.server_public_ip
}

output "client_public_ips" {
  description = "List of Nomad Client Public IPs"
  value       = module.nomad_client.client_public_ips
}

output "nomad_ui_url" {
  description = "Nomad UI Access URL"
  value       = "http://${module.nomad_server.server_public_ip}:4646"
}
