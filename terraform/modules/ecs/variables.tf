variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for ECS networking"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnets for ECS tasks"
  type        = list(string)
}

variable "alb_target_group_arn" {
  description = "ALB target group ARN"
  type        = string
}

variable "container_image" {
  description = "Docker image to run"
  type        = string
}

variable "container_port" {
  description = "Container port exposed"
  type        = number
  default     = 80
}

variable "desired_count" {
  description = "Number of ECS tasks"
  type        = number
  default     = 1
}

variable "cpu" {
  description = "CPU units for Fargate task"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Memory (MB) for Fargate task"
  type        = number
  default     = 512
}
