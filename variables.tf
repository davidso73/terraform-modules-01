variable "aws_region" {
  type        = string
  description = "The AWS region to deploy resources into."
  default     = "us-east-1"
}

variable "ami_id" {
  type        = string
  description = "The AMI ID for the EC2 instances."
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for the application servers."
  default     = "t3.micro"
}

variable "app_bucket_name" {
  type        = string
  description = "Unique name for the application S3 bucket."
}

variable "notification_email" {
  type        = string
  description = "Email address for SNS subscription notifications."
}