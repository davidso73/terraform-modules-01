# Infrastructure & Configuration Management Project

This repository manages the automated deployment of a multi-tier application architecture using Terraform for Infrastructure as Code (IaC) and Ansible for configuration management and application deployment.

## Rapid Project Initialization
Run the following commands in your terminal to safely construct the project skeleton:

```bash
mkdir -p modules/{ec2,iam,load_balancer,networking,rds_postgresql,s3_bucket,sns_topic}
mkdir -p Ansible_modules/{group_vars,inventory,playbooks,roles}

# Create Terraform module files
for dir in modules/*; do
    touch "$dir/main.tf" "$dir/outputs.tf" "$dir/variables.tf"
done

# Create Ansible top-level files
touch Ansible_modules/{ansible.cfg,inventory.ini,README.md,requirements.yml,sites.yml}