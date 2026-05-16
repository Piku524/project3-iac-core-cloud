variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_one_cidr" {
  description = "CIDR block for first public subnet"
  type        = string
}

variable "public_subnet_two_cidr" {
  description = "CIDR block for second public subnet"
  type        = string
}

variable "private_subnet_one_cidr" {
  description = "CIDR block for first private subnet"
  type        = string
}

variable "private_subnet_two_cidr" {
  description = "CIDR block for second private subnet"
  type        = string
}

variable "availability_zone_one" {
  description = "First availability zone"
  type        = string
}

variable "availability_zone_two" {
  description = "Second availability zone"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
