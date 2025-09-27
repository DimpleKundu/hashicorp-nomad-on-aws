##Nomad Cluster Deployment (AWS)

## Overview

This project provisions a **HashiCorp Nomad cluster** (1 server + 1 client) on AWS using **Terraform** and runs a simple **hello-world Nomad job**.
The deployment demonstrates:

* Infrastructure as Code (Terraform)
* Nomad cluster setup with **ACLs enabled** for secure UI access
* Running a containerized sample job

---

## Architecture

* **VPC** with public subnet
* **Nomad Server** (EC2, t3.micro)
* **Nomad Client** (EC2, t3.micro)
* **Security Group** allows:

  * Nomad UI & RPC: 4646, 4647
  * Web application: 80

**Cluster topology:**

```
[Nomad Server] <--- RPC ---> [Nomad Client]
       |                     |
       |                     |-- Runs hello.nomad job
       |
       |-- Nomad UI (HTTP)
```

---

## AWS Credentials

Terraform provisions the EC2 instances automatically using your local AWS CLI credentials.
**No username/password needed in code**. Make sure AWS CLI is configured:

```bash
aws configure
# or set environment variables:
export AWS_ACCESS_KEY_ID=<your_key>
export AWS_SECRET_ACCESS_KEY=<your_secret>
export AWS_DEFAULT_REGION=us-east-1
```

---

## Deployment Steps

1. Initialize Terraform environment:

```bash
cd infra/environments/dev
terraform init
```

2. Apply Terraform to create network, server, and client:

```bash
terraform apply
```

3. Wait for Terraform to complete. It outputs:

```text
server_ip = <public-ip-of-server>
client_ip = <public-ip-of-client>
```

4. Verify Nomad services:

* **Server** is running with ACL enabled
* **Client** is registered

---

## Secure Nomad UI Access

1. On the server machine (or local if port 4646 is open):

```bash
nomad acl bootstrap
```

This outputs the **initial management token**. Copy it.

2. Use this token to access the UI:

```bash
export NOMAD_TOKEN=<your_management_token>
```

3. Open Nomad UI in browser:

```
http://<server_ip>:4646/ui
```

---

## Running the Sample Job

1. Deploy hello-world job:

```bash
nomad job run jobs/hello.nomad
```

2. Check allocation status:

```bash
nomad job status hello
```

3. Access the running web container:

```
http://<client_ip>:5678
```

It should return: `Hello, Nomad!`

---

## Directory Structure

```
.
├── .github/workflows/terraform.yml   # GitHub Actions CI for Terraform
├── infra/
│   ├── cloud-init/                   # EC2 user-data scripts
│   │   ├── nomad-server.yaml
│   │   └── nomad-client.yaml
│   └── environments/dev/             # Terraform environment
├── jobs/
│   └── hello.nomad                    # Nomad sample job
├── local/
│   ├── server.hcl                     # Local server config
│   └── client.hcl                     # Local client config
├── modules/                           # Terraform modules (network, server, client)
├── README.md
└── requirements.txt                   # Python dependencies (optional)
```

---

## Security & Best Practices

* **ACLs enabled** for Nomad server
* **Default policy:** deny
* **Management token** must be kept secret
* **UI only accessible via server IP**

---

## Notes

* This setup **does not require SSH access**—all commands can be run locally or on AWS instances using Terraform-provisioned scripts.
* Docker and Nomad are installed via **cloud-init** automatically.


