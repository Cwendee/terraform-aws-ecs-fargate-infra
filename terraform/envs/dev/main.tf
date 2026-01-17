terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "pruddie-dev"
}

module "vpc" {
  source = "../../modules/vpc"

  project_name = "ecs-fargate-infra"
  environment  = "dev"

  vpc_cidr = "10.0.0.0/16"

  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnets = [
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]

  availability_zones = [
    "us-east-1a",
    "us-east-1b"
  ]
}



module "alb" {
  source = "../../modules/alb"

  project_name = "ecs-fargate-infra"
  environment  = "dev"

  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "ecs" {
  source = "../../modules/ecs"

  project_name = "ecs-fargate-infra"
  environment  = "dev"

  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  alb_target_group_arn = module.alb.target_group_arn

  container_image = "nginx:latest"
  container_port  = 80

  desired_count = 1
  cpu           = 256
  memory        = 512
}
