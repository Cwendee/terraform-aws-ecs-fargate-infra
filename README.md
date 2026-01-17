# Terraform AWS ECS Fargate Infrastructure

Production-style AWS infrastructure built with Terraform, deploying a containerized application on ECS Fargate behind an Application Load Balancer using a modular, environment-based design.

## Architecture Overview

This project provisions a cloud-native container platform on AWS using Terraform modules. 
The infrastructure is designed with security, scalability, and cost-awareness in mind.

```mermaid
flowchart TB
    Internet --> ALB["Application Load Balancer\n(Public Subnets)"]

    subgraph VPC["VPC (10.0.0.0/16)"]
        subgraph Public["Public Subnets"]
            ALB
        end

        subgraph Private["Private Subnets"]
            ECS["ECS Fargate Service"]
            Tasks["ECS Tasks (Containers)"]
        end
    end

    ALB --> TG["Target Group (IP mode)"]
    TG --> ECS
    ECS --> Tasks


---

## 3️⃣ Tech Stack

```md
## Tech Stack

- **Infrastructure as Code:** Terraform
- **Cloud Provider:** AWS
- **Compute:** ECS Fargate
- **Load Balancing:** Application Load Balancer (ALB)
- **Networking:** VPC with public and private subnets
- **IAM:** Least-privilege task execution role
- **Logging:** CloudWatch Logs
- **State Management:** Remote backend (S3)

## Project Structure

terraform/
├── modules/
│   ├── vpc/        # VPC, subnets, routing, NAT
│   ├── alb/        # Application Load Balancer and target group
│   └── ecs/        # ECS cluster, task definition, service
│
└── envs/
    └── dev/        # Dev environment wiring and backend

## Key Design Decisions

- ECS tasks run in **private subnets** with no public IPs
- ALB is the **only public entry point**
- Target group uses **IP mode** (required for Fargate)
- IAM roles follow **least-privilege principles**
- Infrastructure is fully reproducible using Terraform modules

## How to Deploy

```bash
cd terraform/envs/dev
terraform init
terraform plan
terraform apply

terraform destroy


---

## 7️⃣ Challenges & Learnings (Short Teaser)

```md
## Challenges & Learnings

- Proper separation of Terraform modules vs environments
- Managing remote state safely with S3
- Debugging IAM and credential issues
- Incremental infrastructure build to reduce risk

## Case Study

A detailed case study covering architecture decisions, challenges, and lessons learned is available here:

👉 [Read the full case study](LINK_TO_BLOG_OR_DOC)

## Future Improvements

- HTTPS with ACM
- Autoscaling policies for ECS service
- CI/CD pipeline for automated deployments
- Blue/green deployment strategy
