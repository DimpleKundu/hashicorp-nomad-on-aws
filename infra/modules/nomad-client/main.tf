resource "aws_instance" "client" {
  count                  = var.client_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]
  key_name               = var.key_name

  # Pass server IP dynamically into cloud-init
  user_data = templatefile("${path.module}/../../cloud-init/nomad-client.yaml.tpl", {
    server_ip = var.nomad_server_private_ip
  })

  tags = {
    Name = "nomad-client-${count.index + 1}"
  }
}

# --- Outputs ---
output "client_public_ips" {
  description = "List of public IPs of Nomad clients"
  value       = [for c in aws_instance.client : c.public_ip]
}

output "client_private_ips" {
  description = "List of private IPs of Nomad clients"
  value       = [for c in aws_instance.client : c.private_ip]
}
