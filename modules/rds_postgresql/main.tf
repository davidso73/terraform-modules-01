# Subnet group spanning multiple availability zones for high availability
resource "aws_db_subnet_group" "db_subnets" {
  name        = "app-db-subnet-group"
  subnet_ids  = var.private_subnet_ids
  description = "Database subnet collection mapping internal private zones"
  tags        = { Name = "app-db-subnet-group" }
}

# Explicit ingress firewall constraint mapping to the internal computing tier
resource "aws_security_group" "db_sg" {
  name        = "sg_rds_postgres"
  description = "Restrict database ingress to the application compute layer"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL from application cluster instances"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.allowed_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "sg-rds-postgres" }
}

# The engine component block
resource "aws_db_instance" "postgres" {
  identifier             = "app-production-db"
  engine                 = "postgres"
  engine_version         = "15.4"
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  max_allocated_storage  = 100
  storage_type           = "gp3"
  
  db_name                = "app_production"
  username               = "postgres_admin"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  
  skip_final_snapshot    = true # Set to false in actual business pipelines
  publicly_accessible    = false

  tags = { Name = "app-postgresql-instance" }
}