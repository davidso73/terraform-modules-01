output "nginx_public_ip" {
  description = "Public IP address of the Nginx Reverse Proxy server"
  value       = module.ec2.nginx_public_ip
}

output "frontend_private_ip" {
  description = "Private IP address of the Frontend application server"
  value       = module.ec2.frontend_private_ip
}

output "backend_private_ip" {
  description = "Private IP address of the Backend application server"
  value       = module.ec2.backend_private_ip
}

output "worker_private_ip" {
  description = "Private IP address of the Worker server"
  value       = module.ec2.worker_private_ip
}

output "rds_endpoint" {
  description = "The connection endpoint for the RDS PostgreSQL instance"
  value       = module.rds.endpoint
}