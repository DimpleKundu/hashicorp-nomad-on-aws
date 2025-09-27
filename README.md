# Nomad Cluster Deployment (AWS & Local)

## Overview

This project provisions a **HashiCorp Nomad cluster** on AWS using **Terraform** and demonstrates a **hello-world Nomad job**.
It also shows **local Nomad testing** with `server.hcl` and `client.hcl` before cloud deployment.

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
       |-- Nomad UI (HTTP, ACL-secured)
```

---

## AWS Credentials

Terraform provisions the EC2 instances automatically using your **local AWS CLI credentials**:

```bash
aws configure
# or environment variables:
export AWS_ACCESS_KEY_ID=<your_key>
export AWS_SECRET_ACCESS_KEY=<your_secret>
export AWS_DEFAULT_REGION=us-east-1
```

---

## Deployment Steps

### Local Testing (Optional)

1. Start Nomad server locally:

```bash
nomad agent -config=local/server.hcl
```

2. Start Nomad client locally:

```bash
nomad agent -config=local/client.hcl
```

3. Bootstrap ACL for secure UI access:

```bash
nomad acl bootstrap
```

This returns a **management token**. Copy it for UI access.

4. Set environment variable for Nomad CLI:

```bash
export NOMAD_TOKEN=<your_management_token>
```

5. Access Nomad UI locally:

```
http://127.0.0.1:4646/ui
```

---

### Cloud Deployment (AWS)

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

```
server_ip = <public-ip-of-server>
client_ip = <public-ip-of-client>
```

4. Access Nomad server on AWS (ACL token required):

```
http://<server_ip>:4646/ui
```

---

### Running the Sample Job

1. Run the hello-world Nomad job:

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
├── .github/workflows/terraform.yml   # CI/CD Terraform pipeline
├── infra/
│   ├── cloud-init/                   # EC2 user-data scripts (install Nomad, Docker)
│   └── environments/dev/             # Terraform environment
├── jobs/
│   └── hello.nomad                    # Sample Nomad job
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
