variable "ami_id" {
  description = "Ubuntu AMI ID"
  type        = string
  default     = "ami-08c40ec9ead489470" # Ubuntu 22.04 (us-east-1)
}

variable "instance_type" {
  description = "EC2 instance type for Nomad client"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID for Nomad client"
  type        = string
}

variable "sg_id" {
  description = "Security Group ID for Nomad client"
  type        = string
}

variable "key_name" {
  description = "SSH key name for accessing EC2"
  type        = string
}

variable "client_count" {
  description = "Number of Nomad clients to launch"
  type        = number
  default     = 1
}

variable "nomad_server_private_ip" {
  description = "Private IP of Nomad server for clients to join"
  type        = string
}
