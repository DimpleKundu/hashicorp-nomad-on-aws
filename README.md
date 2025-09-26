# 🚀 Nomad Cluster Deployment (AWS)

## Overview
This project provisions a **Nomad cluster** (1 server + 1 client) on AWS using **Terraform** and runs a sample **hello-world Nomad job**.

## Architecture
- **VPC** with public subnet
- **Nomad Server** (EC2, t3.micro)
- **Nomad Client** (EC2, t3.micro)
- **Security Group** allows SSH (22), Nomad UI (4646), and HTTP (80)

## Deployment Steps
```bash
cd infra/environments/dev
terraform init
terraform apply
