provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "../../modules/network"
}

module "nomad_server" {
  source    = "../../modules/nomad-server"
  subnet_id = module.network.subnet_id
  sg_id     = module.network.sg_id
}

module "nomad_client" {
  source    = "../../modules/nomad-client"
  subnet_id = module.network.subnet_id
  sg_id     = module.network.sg_id
}
