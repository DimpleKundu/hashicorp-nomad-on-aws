
resource "aws_instance" "server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]
  key_name               = var.key_name

  # Cloud-init to configure Nomad Server
  user_data = file("${path.module}/../../cloud-init/nomad-server.yaml")

  tags = {
    Name = "nomad-server"
  }
}

# --- Outputs ---
output "server_public_ip" {
  description = "Public IP of the Nomad server"
  value       = aws_instance.server.public_ip
}

output "server_private_ip" {
  description = "Private IP of the Nomad server"
  value       = aws_instance.server.private_ip
}

