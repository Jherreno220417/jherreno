# Variables for AWS 3-Tier Architecture
# Author: Juan - Cloud Consultant

# General Configuration
variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name to be used for resource naming"
  type        = string
  default     = "3tier-webapp"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Owner of the infrastructure"
  type        = string
  default     = "CloudTeam"
}

# Network Configuration
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for private application subnets"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "private_db_subnet_cidrs" {
  description = "CIDR blocks for private database subnets"
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}

# Security Configuration
variable "ssh_allowed_ips" {
  description = "List of IP addresses allowed to SSH to instances"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Replace with your IP for production
}

# Compute Configuration
variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI - Update based on region
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "my-key-pair" # Update with your key pair name
}

# Auto Scaling Configuration
variable "asg_min_size" {
  description = "Minimum number of instances in ASG"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum number of instances in ASG"
  type        = number
  default     = 6
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in ASG"
  type        = number
  default     = 2
}

# Load Balancer Configuration
variable "enable_deletion_protection" {
  description = "Enable deletion protection on ALB"
  type        = bool
  default     = false
}

variable "health_check_path" {
  description = "Health check path for target group"
  type        = string
  default     = "/health"
}

# Database Configuration
variable "db_engine" {
  description = "Database engine"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
  default     = "8.0.35"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Allocated storage for RDS in GB"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Database master username"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}

variable "db_multi_az" {
  description = "Enable Multi-AZ for RDS"
  type        = bool
  default     = true
}

variable "db_backup_retention_period" {
  description = "Number of days to retain database backups"
  type        = number
  default     = 7
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot when destroying RDS"
  type        = bool
  default     = false
}
