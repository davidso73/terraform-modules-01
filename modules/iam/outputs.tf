output "ec2_profile_name" {
  description = "The assigned name for our computing instance execution profile"
  value       = aws_iam_instance_profile.ec2_profile.name
}