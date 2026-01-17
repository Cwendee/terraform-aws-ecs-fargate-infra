terraform {
  backend "s3" {
    bucket  = "pruddie-terraform-remote-state"
    key     = "ecs-fargate-infra/dev/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
