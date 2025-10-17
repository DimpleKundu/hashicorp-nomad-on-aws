# --- Provider ---
provider "aws" {
  region = var.region
}

# --- Network ---
module "network" {
  source = "../../modules/network"
  availability_zone = var.availability_zone 
}

# --- Nomad Server ---
module "nomad_server" {
  source     = "../../modules/nomad-server"
  subnet_id  = module.network.subnet_id
  sg_id      = module.network.sg_id
  key_name   = var.key_name
}

# --- Nomad Client(s) ---
module "nomad_client" {
  source                  = "../../modules/nomad-client"
  subnet_id               = module.network.subnet_id
  sg_id                   = module.network.sg_id
  key_name                = var.key_name
  client_count            = var.client_count
  nomad_server_private_ip = module.nomad_server.server_private_ip
}

# --- Outputs ---
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
