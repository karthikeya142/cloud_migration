

resource "aws_cloudwatch_event_rule" "every_hour" {
  name                = "every_hour_rule"
  schedule_expression = "cron(*/2 * * * ? *)"  
}

# Set the target of the EventBridge rule to the Lambda function
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.every_hour.name
  arn       = aws_lambda_function.lambda_function.arn
  target_id = "my_lambda_target"
}

# Add permissions to the Lambda function's execution role to allow EventBridge to invoke it
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_hour.arn
}
