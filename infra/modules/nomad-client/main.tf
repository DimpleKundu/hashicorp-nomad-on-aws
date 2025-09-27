resource "aws_instance" "client" {
  ami           = "ami-08c40ec9ead489470" # Ubuntu 22.04 in us-east-1
  instance_type = "t3.micro"

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]

  user_data = file("${path.module}/../../cloud-init/nomad-client.yaml")

  tags = { Name = "nomad-client" }
}

output "client_ip" {
  value = aws_instance.client.public_ip
}
