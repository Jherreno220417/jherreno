# Outputs for AWS 3-Tier Architecture
# Author: Juan - Cloud Consultant

# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

# Subnet Outputs
output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_app_subnet_ids" {
  description = "IDs of the private application subnets"
  value       = aws_subnet.private_app[*].id
}

output "private_db_subnet_ids" {
  description = "IDs of the private database subnets"
  value       = aws_subnet.private_db[*].id
}

# Load Balancer Outputs
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "Zone ID of the Application Load Balancer"
  value       = aws_lb.main.zone_id
}

output "application_url" {
  description = "URL to access the application"
  value       = "http://${aws_lb.main.dns_name}"
}

# Auto Scaling Group Outputs
output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.web.name
}

output "autoscaling_group_arn" {
  description = "ARN of the Auto Scaling Group"
  value       = aws_autoscaling_group.web.arn
}

output "launch_template_id" {
  description = "ID of the Launch Template"
  value       = aws_launch_template.web.id
}

# Security Group Outputs
output "alb_security_group_id" {
  description = "ID of the ALB security group"
  value       = aws_security_group.alb.id
}

output "web_security_group_id" {
  description = "ID of the web server security group"
  value       = aws_security_group.web.id
}

output "rds_security_group_id" {
  description = "ID of the RDS security group"
  value       = aws_security_group.rds.id
}

# Database Outputs
output "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = aws_db_instance.main.endpoint
  sensitive   = true
}

output "rds_instance_id" {
  description = "ID of the RDS instance"
  value       = aws_db_instance.main.id
}

output "rds_db_name" {
  description = "Name of the database"
  value       = aws_db_instance.main.db_name
}

# NAT Gateway Outputs
output "nat_gateway_ids" {
  description = "IDs of the NAT Gateways"
  value       = aws_nat_gateway.main[*].id
}

output "nat_gateway_public_ips" {
  description = "Public IP addresses of the NAT Gateways"
  value       = aws_eip.nat[*].public_ip
}

# Monitoring Outputs
output "cloudwatch_alarm_high_cpu_arn" {
  description = "ARN of the high CPU CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.high_cpu.arn
}

output "cloudwatch_alarm_low_cpu_arn" {
  description = "ARN of the low CPU CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.low_cpu.arn
}

# Summary Output
output "deployment_summary" {
  description = "Summary of the deployed infrastructure"
  value = {
    vpc_id                = aws_vpc.main.id
    application_url       = "http://${aws_lb.main.dns_name}"
    autoscaling_group     = aws_autoscaling_group.web.name
    rds_endpoint          = aws_db_instance.main.endpoint
    availability_zones    = var.availability_zones
    environment           = var.environment
  }
}
