# AWS 3-Tier Web Application Infrastructure

## 📋 Project Overview

This repository contains Infrastructure as Code (IaC) using Terraform to deploy a highly available, scalable 3-tier web application on AWS. The architecture follows AWS best practices for security, reliability, and cost optimization.

## 🏗️ Architecture

The infrastructure consists of three tiers:

1. **Presentation Tier**: Application Load Balancer distributing traffic across multiple availability zones
2. **Application Tier**: Auto Scaling Group of EC2 instances running the application
3. **Data Tier**: Multi-AZ RDS database with automated backups

### Architecture Diagram

```
Internet
    |
    v
[Application Load Balancer]
    |
    +---> [Public Subnet AZ-1] [Public Subnet AZ-2]
              |                        |
              v                        v
          [NAT GW]                 [NAT GW]
              |                        |
    +---> [Private Subnet AZ-1] [Private Subnet AZ-2]
    |         |                        |
    |         v                        v
    |     [EC2 ASG]              [EC2 ASG]
    |         |                        |
    |         +------------+-----------+
    |                      |
    |                      v
    +---> [Private DB Subnet AZ-1] [Private DB Subnet AZ-2]
                          |
                          v
                    [RDS Multi-AZ]
```

## 🚀 Features

- **High Availability**: Resources deployed across multiple availability zones
- **Auto Scaling**: Automatic scaling based on CPU utilization
- **Security**: 
  - Private subnets for application and database tiers
  - Security groups with least privilege access
  - Encrypted database storage
  - SSL/TLS support on ALB
- **Monitoring**: CloudWatch alarms for critical metrics
- **Cost Optimization**: NAT Gateway sharing, appropriate instance sizing

## 📁 Project Structure

```
.
├── main.tf                 # Main Terraform configuration
├── variables.tf           # Input variables
├── outputs.tf            # Output values
├── terraform.tfvars.example  # Example variable values
├── modules/
│   ├── networking/       # VPC, Subnets, Route Tables
│   ├── compute/         # EC2, Auto Scaling, ALB
│   ├── database/        # RDS configuration
│   └── security/        # Security Groups, IAM roles
├── scripts/
│   └── user_data.sh     # EC2 initialization script
└── README.md

```

## 📋 Prerequisites

- AWS Account with appropriate permissions
- Terraform >= 1.0
- AWS CLI configured with credentials
- SSH key pair for EC2 access

## 🔧 Deployment Instructions

### 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/aws-3tier-terraform.git
cd aws-3tier-terraform
```

### 2. Configure variables

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your specific values
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Review the execution plan

```bash
terraform plan
```

### 5. Deploy the infrastructure

```bash
terraform apply
```

### 6. Access outputs

```bash
terraform output
```

## 🔐 Security Considerations

- Database credentials are managed via AWS Secrets Manager
- All data at rest is encrypted
- Security groups follow the principle of least privilege
- VPC Flow Logs enabled for network monitoring
- CloudTrail enabled for audit logging

## 💰 Cost Estimation

Approximate monthly cost for this infrastructure:
- Application Load Balancer: $16-20
- EC2 Instances (t3.micro x2): $15-20
- NAT Gateways (x2): $65-70
- RDS (db.t3.micro Multi-AZ): $30-35
- **Total**: ~$126-145/month

*Costs may vary based on region and actual usage*

## 🧹 Cleanup

To destroy all resources:

```bash
terraform destroy
```

## 📊 Monitoring & Alerts

CloudWatch alarms are configured for:
- High CPU utilization (>80%)
- Low healthy host count
- Database connection errors
- High database CPU

## 🔄 CI/CD Integration

This infrastructure code can be integrated with:
- GitHub Actions (see `.github/workflows/terraform.yml`)
- GitLab CI/CD
- Jenkins
- Azure DevOps

## 📚 Additional Resources

- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS VPC Best Practices](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-best-practices.html)

## 👤 Author

**Juan** - Cloud Consultant | AWS Certified Solutions Architect

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the issues page.

---

⭐ If you find this project useful, please consider giving it a star!
