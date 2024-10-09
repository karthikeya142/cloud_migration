# Attach a policy to the Lambda Execution Role to allow Lambda to read from S3
resource "aws_iam_policy" "lambda_s3_policy" {
  name = "lambda_s3_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:s3:::devil971/lambda_function.zip"  # Replace with your S3 bucket name and object
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# IAM Role for accessing the secret
resource "aws_iam_role" "secrete_role" {
  name = "secrete_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid = ""
      }
    ]
  })
}

# IAM Policy to allow access to the secret
resource "aws_iam_policy" "secrets_manager_policy" {
  name = "secrets_manager_access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "secretsmanager:GetSecretValue",
        Effect = "Allow",
        Resource = aws_secretsmanager_secret.my_secret.arn  # Reference the secret's ARN
      }
    ]
  })
}

