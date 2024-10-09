
resource "aws_secretsmanager_secret" "my_secret" {
  name        = "my_secret2"  # Name of the secret
  description = "This is a test secret"
  

 
}

resource "aws_secretsmanager_secret_version" "my_secret_version" {
  secret_id     = aws_secretsmanager_secret.my_secret.id
  secret_string = jsonencode({
    username = "karthik"  
    password = "143"
  })
}
