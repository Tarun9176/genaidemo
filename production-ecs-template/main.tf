# Production ECS Terraform Template - AWS Well-Architected Framework
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "ecs/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

# Cost tracking and compliance tags
locals {
  common_tags = {
    Environment   = var.environment
    Project       = var.project_name
    Owner         = var.owner
    CostCenter    = var.cost_center
    Application   = var.cluster_name
    ManagedBy     = "Terraform"
    CreatedDate   = formatdate("YYYY-MM-DD", timestamp())
    Compliance    = var.compliance_level
  }
}

# Secrets management module
module "secrets" {
  source = "./modules/secrets"
  
  name_prefix = var.cluster_name
  db_username = var.db_username
  db_password = var.db_password
  api_key     = var.api_key
  tags        = local.common_tags
}

# Security groups module
module "security" {
  source = "./modules/security"
  
  name_prefix    = var.cluster_name
  vpc_id         = var.vpc_id
  container_port = var.container_port
  tags           = local.common_tags
}

# IAM roles module
module "iam" {
  source = "./modules/iam"
  
  name_prefix = var.cluster_name
  secret_arns = [
    module.secrets.db_secret_arn,
    module.secrets.app_secret_arn
  ]
  tags = local.common_tags
}

# Networking module
module "networking" {
  source = "./modules/networking"
  
  name_prefix           = var.cluster_name
  vpc_id               = var.vpc_id
  subnet_ids           = var.subnet_ids
  container_port       = var.container_port
  alb_security_group_id = module.security.alb_security_group_id
  tags                 = local.common_tags
}

# ECS module with auto scaling
module "ecs" {
  source = "./modules/ecs"
  
  cluster_name          = var.cluster_name
  environment           = var.environment
  vpc_id               = var.vpc_id
  subnet_ids           = var.subnet_ids
  task_cpu             = var.task_cpu
  task_memory          = var.task_memory
  container_image      = var.container_image
  container_port       = var.container_port
  desired_count        = var.desired_count
  min_capacity         = var.min_capacity
  max_capacity         = var.max_capacity
  execution_role_arn   = module.iam.ecs_task_execution_role_arn
  ecs_security_group_id = module.security.ecs_security_group_id
  target_group_arn     = module.networking.target_group_arn
  db_secret_arn        = module.secrets.db_secret_arn
  app_secret_arn       = module.secrets.app_secret_arn
  tags                 = local.common_tags
}