resource "aws_iam_role" "step_function_role" {
  name = "step_function_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = "sts:AssumeRole",
      Principal = {
        Service = "states.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "step_function_policy_attach" {
  role       = aws_iam_role.step_function_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaRole"
}


resource "aws_sfn_state_machine" "lambda_step_function" {
  name     = "LambdaStepFunction"
  role_arn = aws_iam_role.step_function_role.arn

  definition = jsonencode({
    Comment: "Step Function to trigger Lambda for Secrets Manager",
    StartAt: "InvokeLambda",
    States: {
      "InvokeLambda": {
        Type: "Task",
        Resource: aws_lambda_function.lambda_function.arn,
        End: true
      }
    }
  })
}
