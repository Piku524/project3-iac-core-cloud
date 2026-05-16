Project — Infrastructure as Code (IaC) for Core AWS Resources

## Overview

This project was created to implement Infrastructure as Code (IaC) on AWS using Terraform. The main goal of this project was to provision and manage core AWS infrastructure resources using reusable Terraform modules and automation practices.
The complete infrastructure was deployed using Terraform without manually creating resources from the AWS Management Console.

This project also includes remote backend configuration, Policy-as-Code validation, and Terraform drift detection.

# AWS Region

ap-south-1

# What Was Built

The following AWS resources were provisioned as part of this project.

## Networking

- Amazon VPC
- Two Public Subnets
- Two Private Subnets
- Internet Gateway
- Public Route Table
- Private Route Table
- Route Table Associations

## Compute

- Amazon EC2 Instance
- Amazon Linux 2023 AMI
- Apache Web Server using User Data
- Security Group allowing HTTP and SSH access

## Storage

- Amazon S3 Bucket with:
  - Versioning enabled
  - Server-side encryption enabled
  - Lifecycle management rules
  - Public access block enabled

## Database

- Amazon RDS MySQL Instance
- Private subnet deployment
- Encrypted storage enabled
- Restricted database access using Security Groups

## Backend Configuration

- Remote Terraform State stored in Amazon S3
- DynamoDB table for Terraform state locking

## Security & Validation

- Security Groups
- OPA / Conftest Policy Validation
- Terraform Drift Detection
- Environment variable-based secret handling

# Architecture

                               Internet
                                   |
                           Internet Gateway
                                   |
                          Public Route Table
                                   |
                  ---------------------------------
                  |                               |
                  v                               v
         Public Subnet 1                 Public Subnet 2
                  |
                  v
            EC2 Web Server

----------------------------------------------------------------

          Private Route Table           Private Route Table
                  |                               |
                  v                               v
         Private Subnet 1               Private Subnet 2
                  |
                  v
             RDS MySQL Database

----------------------------------------------------------------

               Amazon S3 Storage Bucket
        - Versioning Enabled
        - Encryption Enabled
        - Lifecycle Rules Enabled

----------------------------------------------------------------

               Terraform Remote Backend
                   ├── S3 State Bucket
                   └── DynamoDB Lock Table

----------------------------------------------------------------

              OPA Policy Validation
              Terraform Drift Detection

# Project Structure

project3-iac-core-cloud/
│
├── backend.tf
├── providers.tf
├── versions.tf
├── variables.tf
├── main.tf
├── outputs.tf
├── README.md
├── .gitignore
│
├── modules/
│   ├── network/
│   ├── compute/
│   ├── storage/
│   └── database/
│
├── policies/
│   └── terraform_policy.rego
│
└── scripts/
    └── drift-check.sh

# Terraform Modules

The infrastructure was organized using reusable Terraform modules.

| Module   | Purpose                                                  |
| -------- | -------------------------------------------------------- |
| network  | Creates VPC, subnets, route tables, and internet gateway |
| compute  | Deploys EC2 instance and security groups                 |
| storage  | Creates and secures the S3 bucket                        |
| database | Deploys private RDS MySQL database                       |

# Remote Backend Setup

Terraform remote backend was configured using:

## Amazon S3

Used for:

* Remote Terraform state storage
* State versioning
* State encryption

## Amazon DynamoDB

Used for:

* Terraform state locking
* Preventing concurrent infrastructure changes
* Better and safer Terraform state management

# Policy-as-Code

OPA and Conftest were used to validate Terraform plans before deployment.

Policies implemented include:

* Restrict EC2 instances to approved instance types
* Ensure VPC DNS settings are enabled
* Ensure S3 public access is blocked
* Ensure RDS databases are not publicly accessible
* Restrict public access to database ports

## Validation Command

```bash
terraform show -json tfplan > tfplan.json

conftest test tfplan.json --policy policies
```

# Drift Detection

Terraform drift detection was implemented using a custom shell script.

## Run Drift Detection

```bash
./scripts/drift-check.sh
```

This checks whether deployed infrastructure matches the Terraform state file.

# Deployment Steps

## Initialize Terraform

```bash
terraform init
```

## Validate Configuration

```bash
terraform validate
```

## Generate Terraform Plan

```bash
terraform plan -out=tfplan
```

## Convert Plan to JSON

```bash
terraform show -json tfplan > tfplan.json
```

## Run Policy Validation

```bash
conftest test tfplan.json --policy policies
```

## Deploy Infrastructure

```bash
terraform apply tfplan
```

# Secret Management

Sensitive database credentials were not stored directly inside Terraform files or GitHub.

The database password was passed securely using environment variables.

## Example

```bash
export TF_VAR_db_password='your-password'
```

# Infrastructure Verification

## Verify Web Server

```bash
curl http://<EC2_PUBLIC_IP>
```

## Verify AWS Resources

```bash
aws ec2 describe-vpcs --region ap-south-1
```

```bash
aws ec2 describe-instances --region ap-south-1
```

```bash
aws s3 ls
```

```bash
aws rds describe-db-instances --region ap-south-1
```

# Challenges Faced

## RDS Subnet Group Requirement

While configuring the RDS subnet group, multiple private subnets across different Availability Zones were required.

### Solution

* Configured two private subnets across:

  * ap-south-1a
  * ap-south-1b

## Terraform State Management

Managing Terraform state safely was important during infrastructure changes.

### Solution

* Configured S3 remote backend
* Enabled DynamoDB state locking

## Policy Validation Adjustments

Some policy validations required updates for compatibility with newer OPA syntax.

### Solution

* Updated Rego validation rules
* Re-tested policies using Conftest

# Key Learnings

This project helped me understand:

* Terraform modular architecture
* AWS networking and routing
* EC2 and RDS provisioning
* Secure cloud infrastructure deployment
* Remote Terraform backend configuration
* DynamoDB state locking
* Policy-as-Code implementation
* Drift detection workflows
* Infrastructure validation and automation
* DevOps and Infrastructure Engineering practices

# Future Improvements

Possible future enhancements include:

* CI/CD integration using GitHub Actions
* Load Balancer integration
* CloudWatch monitoring
* Auto Scaling Groups
* Container-based deployment
* Multi-environment support

# Cleanup

To avoid AWS charges after testing:

```bash
terraform destroy
```

# Author
Priyanka Kumari Yadav


