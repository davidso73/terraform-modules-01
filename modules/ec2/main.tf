variable "vpc_id" {}
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "ami_id" {}
variable "instance_type" {}
variable "iam_profile" {}

# Create SSH key pair dynamically 
resource "aws_key_pair" "deployer" {
  key_name   = "infrastructure-deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD..." # Insert your real public key string here
}

# 1. Edge Web Nginx Server
resource "aws_instance" "nginx" {
  ami                  = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = var.public_subnets[0]
  iam_instance_profile = var.iam_profile
  key_name             = aws_key_pair.deployer.key_name

  tags = {
    Name = "app-nginx-proxy"
    Role = "proxy"
  }
}

# 2. Internal Frontend Server
resource "aws_instance" "frontend" {
  ami                  = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = var.private_subnets[0]
  iam_instance_profile = var.iam_profile
  key_name             = aws_key_pair.deployer.key_name

  tags = {
    Name = "app-frontend-srv"
    Role = "frontend"
  }
}

# 3. Internal Backend API Server
resource "aws_instance" "backend" {
  ami                  = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = var.private_subnets[1]
  iam_instance_profile = var.iam_profile
  key_name             = aws_key_pair.deployer.key_name

  tags = {
    Name = "app-backend-srv"
    Role = "backend"
  }
}

# 4. Background Workers Processing Node
resource "aws_instance" "worker" {
  ami                  = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = var.private_subnets[2]
  iam_instance_profile = var.iam_profile
  key_name             = aws_key_pair.deployer.key_name

  tags = {
    Name = "app-worker-srv"
    Role = "worker"
  }
}