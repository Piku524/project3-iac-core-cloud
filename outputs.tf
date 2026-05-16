output "vpc_id" {
  value = module.network.vpc_id
}

output "web_server_public_ip" {
  value = module.compute.web_server_public_ip
}

output "storage_bucket_name" {
  value = module.storage.storage_bucket_name
}

output "database_endpoint" {
  value     = module.database.database_endpoint
  sensitive = true
}
