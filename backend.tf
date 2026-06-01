terraform {
  backend "s3" {
    bucket         = "your-global-terraform-state-bucket" 
    key            = "projects/app-infrastructure/terraform.tfstate"
    region         = "us-east-1" # Replace with your administrative region
    use_lockfile = "terraform-lock-table"
    encrypt        = true
  }
}