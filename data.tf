data "aws_s3_object" "lambda_layer_hash"{
    bucket = var.bucket_name
    key = "lambda_function.zip"
    depends_on = [ aws_s3_bucket.lambda_bucket ]
}

resource "aws_lambda_layer_version" "lambda_layer" {
  s3_bucket = var.bucket_name
  s3_key = "lambda_function.zip"
  source_code_hash = data.aws_s3_object.lambda_layer_hash.version_id
  layer_name = "lambda_function"
  compatible_runtimes = ["python3.9"]
}