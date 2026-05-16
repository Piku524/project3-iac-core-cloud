provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "project3"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "Priyanka"
    }
  }
}
