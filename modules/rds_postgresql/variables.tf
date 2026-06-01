variable "vpc_id" {
  type        = string
  description = "The target Virtual Private Cloud ID."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Isolated private subnet IDs for the RDS Subnet Group."
}

variable "allowed_sg_id" {
  type        = string
  description = "The application security group allowed to talk to the database."
}

variable "db_password" {
  type        = string
  description = "Master password for the PostgreSQL administrator account."
  sensitive   = true
}

variable "allocated_storage" {
  type        = number
  default     = 20
}

variable "instance_class" {
  type        = string
  default     = "db.t4g.micro"
}