output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_one_id" {
  description = "Public subnet one ID"
  value       = aws_subnet.public_one.id
}

output "public_subnet_two_id" {
  description = "Public subnet two ID"
  value       = aws_subnet.public_two.id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = [
    aws_subnet.private_one.id,
    aws_subnet.private_two.id
  ]
}
