
# Create the IAM role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Attach the basic execution policy for logging permissions
resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
  name       = "lambda_policy_attachment"
  roles      = [aws_iam_role.lambda_exec_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
# Attach the policy to the Lambda execution role
resource "aws_iam_role_policy_attachment" "lambda_s3_policy_attachment" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_s3_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_secrets_manager_attachment" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.secrets_manager_policy.arn
}



# Package and create the Lambda function
resource "aws_lambda_function" "lambda_function" {
  function_name = "my_lambda1"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "lambda_function.lambda_handler"  # filename.function_name
  runtime       = "python3.9"   
  s3_bucket = "devil971"
  s3_key = "lambda_function.zip"                   # Python runtime
  # filename          = "./source/lambda_function.zip" # Reference the ZIP file
  

  memory_size = 128
  timeout     = 10
  layers = [
    aws_lambda_layer_version.lambda_layer.arn
  ]

  depends_on = [ aws_s3_bucket.lambda_bucket ]

 
}




