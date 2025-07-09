# ECS Terraform Template

This Terraform template creates a complete Amazon ECS (Elastic Container Service) infrastructure following AWS best practices for code modularity and state management.

## Architecture Overview

The template creates:
- **ECS Cluster**: Logical grouping for container services
- **ECS Service**: Manages task deployment and scaling
- **Application Load Balancer**: Distributes traffic with health checks
- **Security Groups**: Network security for ALB and ECS tasks
- **IAM Roles**: Permissions for ECS task execution
- **CloudWatch Logs**: Centralized logging for containers

## Best Practices Implemented

### 1. Code Modularity
- **Modular Design**: ECS resources are organized in a reusable module (`modules/ecs/`)
- **Separation of Concerns**: Main configuration, variables, and outputs are separated
- **Reusability**: Module can be used across different environments

### 2. State Management
- **Remote State**: Uses S3 backend with DynamoDB locking
- **State Encryption**: Terraform state is encrypted at rest
- **Team Collaboration**: Prevents concurrent modifications with state locking

### 3. Security Best Practices
- **Least Privilege**: IAM roles with minimal required permissions
- **Network Security**: Security groups with specific ingress/egress rules
- **Encryption**: State file encryption enabled

### 4. Resource Organization
- **Consistent Tagging**: All resources tagged with Environment, Name, and ManagedBy
- **Naming Conventions**: Predictable resource naming with environment prefixes
- **Variable Validation**: Input validation for critical variables

## Prerequisites

1. **AWS CLI** configured with appropriate credentials
2. **Terraform** >= 1.0 installed
3. **Existing VPC** with public subnets across multiple AZs
4. **S3 Bucket** for Terraform state storage
5. **DynamoDB Table** for state locking

## Quick Start

### 1. Clone and Configure
```bash
# Navigate to the project directory
cd Demo

# Copy the example variables file
copy terraform.tfvars.example terraform.tfvars

# Edit terraform.tfvars with your specific values
notepad terraform.tfvars
```

### 2. Update Backend Configuration
Edit `main.tf` and update the backend configuration:
```hcl
backend "s3" {
  bucket         = "your-terraform-state-bucket"  # Your S3 bucket
  key            = "ecs/terraform.tfstate"
  region         = "us-west-2"                    # Your region
  dynamodb_table = "your-terraform-locks"        # Your DynamoDB table
  encrypt        = true
}
```

### 3. Deploy Infrastructure
```bash
# Initialize Terraform
terraform init

# Review the execution plan
terraform plan

# Apply the configuration
terraform apply
```

### 4. Access Your Application
After deployment, use the load balancer DNS name from the output:
```bash
# Get the load balancer DNS
terraform output load_balancer_dns
```

## Configuration

### Required Variables
- `environment`: Environment name (dev/staging/prod)
- `vpc_id`: VPC ID for resource deployment
- `subnet_ids`: List of subnet IDs across multiple AZs

### Optional Variables
- `aws_region`: AWS region (default: us-west-2)
- `cluster_name`: ECS cluster name (default: my-ecs-cluster)
- `task_cpu`: CPU allocation (default: 256)
- `task_memory`: Memory allocation (default: 512)
- `container_image`: Docker image (default: nginx:latest)
- `container_port`: Application port (default: 80)
- `desired_count`: Number of tasks (default: 2)

## File Structure

```
Demo/
├── main.tf                    # Main Terraform configuration
├── variables.tf               # Input variable definitions
├── outputs.tf                 # Output value definitions
├── terraform.tfvars.example   # Example variable values
├── README.md                  # This documentation
└── modules/
    └── ecs/
        ├── main.tf            # ECS module resources
        ├── variables.tf       # Module input variables
        └── outputs.tf         # Module output values
```

## Outputs

The template provides these outputs:
- `cluster_arn`: ECS cluster ARN
- `service_arn`: ECS service ARN
- `task_definition_arn`: Task definition ARN
- `load_balancer_dns`: Public DNS for application access

## Customization

### Adding Environment-Specific Configurations
Create separate `.tfvars` files for each environment:
```bash
# Development environment
terraform apply -var-file="dev.tfvars"

# Production environment
terraform apply -var-file="prod.tfvars"
```

### Scaling the Application
Modify the `desired_count` variable to scale your application:
```hcl
desired_count = 5  # Run 5 task instances
```

## Cleanup

To destroy the infrastructure:
```bash
terraform destroy
```

## Troubleshooting

### Common Issues
1. **VPC/Subnet Issues**: Ensure subnets are in different AZs and have internet access
2. **State Lock**: If state is locked, check DynamoDB table for stuck locks
3. **IAM Permissions**: Ensure AWS credentials have necessary ECS, EC2, and IAM permissions

### Monitoring
- **CloudWatch Logs**: Check `/ecs/{cluster_name}` log group
- **ECS Console**: Monitor service health and task status
- **Load Balancer**: Check target group health in EC2 console

## Security Considerations

- Review security group rules for your specific use case
- Consider using private subnets with NAT gateway for production
- Implement proper secret management for sensitive data
- Enable AWS CloudTrail for audit logging