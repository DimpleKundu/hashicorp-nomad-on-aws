variable "ami_id" {
  description = "Ubuntu AMI ID"
  type        = string
  default     = "ami-08c40ec9ead489470" # Ubuntu 22.04 (us-east-1)
}

variable "instance_type" {
  description = "EC2 instance type for Nomad server"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID for Nomad server"
  type        = string
}

variable "sg_id" {
  description = "Security Group ID for Nomad server"
  type        = string
}

variable "key_name" {
  description = "SSH key name for accessing EC2"
  type        = string
}
