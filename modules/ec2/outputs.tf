output "nginx_public_ip" {
  value = aws_instance.nginx.public_ip
}

output "frontend_private_ip" {
  value = aws_instance.frontend.private_ip
}

output "backend_private_ip" {
  value = aws_instance.backend.private_ip
}

output "worker_private_ip" {
  value = aws_instance.worker.private_ip
}