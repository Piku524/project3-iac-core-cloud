output "web_server_public_ip" {
  value = aws_instance.web.public_ip
}

output "web_security_group_id" {
  value = aws_security_group.web.id
}
