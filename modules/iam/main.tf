# Assume Role Trust Policy for EC2
resource "aws_iam_role" "ec2_role" {
  name = "app-ec2-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Inline Application Permissions Policy
resource "aws_iam_policy" "app_policy" {
  name        = "app-resource-execution-policy"
  description = "Provides minimal privileges for application storage and notification tasks"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # S3 Access Control Block
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ]
        Resource = [
          "arn:aws:s3:::*", # For real production environments, scope explicitly to var.target_bucket_arn
          "arn:aws:s3:::*/*"
        ]
      },
      # SNS Publishing Permission Block
      {
        Effect = "Allow"
        Action = [
          "sns:Publish",
          "sns:GetTopicAttributes",
          "sns:ListSubscriptionsByTopic"
        ]
        Resource = "*" # Scopes permissions to send message events to all platform topics
      }
    ]
  })
}

# Attach the policy to our execution role
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.app_policy.arn
}

# Instance Profile block requested by the EC2 Module resource
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "app-ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}