
variable "bucket_name" {
  default = "devil971"
  
}

# Create an S3 bucket
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = var.bucket_name  # Choose a globally unique name
}




resource "aws_s3_object" "uploaded_file" {
  bucket = aws_s3_bucket.lambda_bucket.bucket
 key    = "lambda_function.zip"                        # Object name in the bucket
  source = "${path.module}/source/lambda_function.zip"  # Path to the ZIP file
  acl    = "private"
  # Optional: Add tags to the object
  tags = {
    Name = "Uploaded Example File"
  }
}


