terraform {
  backend "s3" {
    bucket         = "project3-state-priyanka"
    key            = "project3/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "project3-terraform-locks"
    encrypt        = true
  }
}
