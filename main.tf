terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "ecs/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  cost_tags = {
    Environment = var.environment
    Project     = var.project_name
    Owner       = var.owner
    CostCenter  = var.cost_center
    Application = var.cluster_name
    ManagedBy   = "Terraform"
    CreatedDate = formatdate("YYYY-MM-DD", timestamp())
  }
}

module "secrets" {
  source = "./modules/secrets"

  name_prefix = var.cluster_name
  db_username = var.db_username
  db_password = var.db_password
  api_key     = var.api_key
  tags        = local.cost_tags
}

module "ecs" {
  source = "./modules/ecs"

  cluster_name    = var.cluster_name
  environment     = var.environment
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids
  task_cpu        = var.task_cpu
  task_memory     = var.task_memory
  container_image = var.container_image
  container_port  = var.container_port
  desired_count   = var.desired_count
  min_capacity    = var.min_capacity
  max_capacity    = var.max_capacity
  db_secret_arn   = module.secrets.db_secret_arn
  app_secret_arn  = module.secrets.app_secret_arn
  tags            = local.cost_tags
}