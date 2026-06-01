module "networking" {
  source = "./modules/networking"
}

module "iam" {
  source = "./modules/iam"
}

module "s3" {
  source      = "./modules/s3_bucket"
  bucket_name = var.app_bucket_name
}

module "sns" {
  source             = "./modules/sns_topic"
  notification_email = var.notification_email
}

module "rds" {
  source             = "./modules/rds_postgresql"
  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
  db_password        = var.db_password
  allowed_sg_id      = module.networking.backend_sg_id
}

module "ec2" {
  source          = "./modules/ec2"
  vpc_id          = module.networking.vpc_id
  public_subnets  = module.networking.public_subnet_ids
  private_subnets = module.networking.private_subnet_ids
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  iam_profile     = module.iam.ec2_profile_name
}