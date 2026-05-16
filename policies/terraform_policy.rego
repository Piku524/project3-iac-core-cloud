package main

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_instance"
  resource.change.after.instance_type != "t3.micro"
  msg := "EC2 instance must use t3.micro."
}

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_vpc"
  resource.change.after.enable_dns_support != true
  msg := "VPC DNS support must be enabled."
}

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_vpc"
  resource.change.after.enable_dns_hostnames != true
  msg := "VPC DNS hostnames must be enabled."
}

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_s3_bucket_public_access_block"
  resource.change.after.block_public_acls != true
  msg := "S3 must block public ACLs."
}

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_s3_bucket_public_access_block"
  resource.change.after.block_public_policy != true
  msg := "S3 must block public bucket policies."
}

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_db_instance"
  resource.change.after.publicly_accessible == true
  msg := "RDS must not be publicly accessible."
}

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_db_instance"
  resource.change.after.storage_encrypted != true
  msg := "RDS storage encryption must be enabled."
}

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_security_group"
  ingress := resource.change.after.ingress[_]
  ingress.from_port == 3306
  ingress.cidr_blocks[_] == "0.0.0.0/0"
  msg := "Database port 3306 must not be open to internet."
}
