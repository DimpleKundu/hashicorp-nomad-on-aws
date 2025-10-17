variable "region" {
  description = "AWS region to deploy in"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "SSH key name to use for EC2 instances"
  type        = string
  default     = "nomad-key" # must exist in your AWS account
}

variable "client_count" {
  description = "Number of Nomad clients to deploy"
  type        = number
  default     = 1
}

variable "availability_zone" {
  description = "AWS availability zone for the subnet"
  type        = string
  default     = "us-east-1a"
}
