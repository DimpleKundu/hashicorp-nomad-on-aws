# Nomad Cluster Deployment Project


This repository contains Terraform code and scripts to deploy a secure, scalable HashiCorp Nomad cluster on Azure.

## Repo Structure
- infra/environments/dev : Terraform environment for dev
- infra/modules : reusable Terraform modules
- infra/ssh : SSH keys (private keys are .gitignored)

## Next Steps
1. Install Azure CLI and Terraform
2. Create Azure Service Principal for Terraform
3. Initialize Terraform backend
4. Deploy network, VMs, and Nomad agents
5. Access Nomad UI via SSH tunnel
6. Deploy sample hello-world Nomad job
"