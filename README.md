# terraform-aws-vpc-ec2-alb
# AWS VPC + EC2 + ALB — Terraform Infrastructure

Provisions a production-style AWS network from scratch: VPC, public/private
subnets, Internet Gateway, NAT Gateway, route tables, an EC2 instance in the
private subnet, and an Application Load Balancer exposing it to the internet.

## Architecture

![architecture](docs/architecture.png)

- VPC (10.0.0.0/16)
- Public subnet (10.0.1.0/24) + Private subnet (10.0.2.0/24) — ap-northeast-1
- Internet Gateway (public egress) + NAT Gateway (private egress)
- EC2 instance (private subnet) behind an Application Load Balancer (public subnet)
- Security group allowing HTTP/HTTPS to the ALB

## Prerequisites
- Terraform >= 1.5.0
- AWS CLI configured (`aws configure`)
- AWS account with permissions for VPC/EC2/ELB resources

## Usage
```bash
git clone https://github.com/<you>/<repo>.git
cd <repo>
cp terraform.tfvars.example terraform.tfvars   # fill in your values
terraform init
terraform plan
terraform apply
```

## Outputs
| Output | Description |
|---|---|
| `loadbalancer_dns_name` | Public DNS name of the ALB |
| `ec2_public_ip` | Public IP (if applicable) |

## Cleanup
```bash
terraform destroy
```

## Module structure
| Module | Resource |
|---|---|
| `vpc` | VPC |
| `subnet` | Public + private subnets |
| `igw` | Internet Gateway |
| `nat` | NAT Gateway |
| `route_table` | Route tables/associations |
| `ec2` | EC2 instance |
| `lb` | Application Load Balancer |
