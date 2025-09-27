resource "aws_instance" "server" {
  ami           = "ami-08c40ec9ead489470" # Ubuntu 22.04 in us-east-1
  instance_type = "t3.micro"

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]

  user_data = file("${path.module}/../../cloud-init/nomad-server.yaml")

  tags = { Name = "nomad-server" }
}

output "server_ip" {
  value = aws_instance.server.public_ip
}
