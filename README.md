I have python job in local so i need to deploy in aws cloud using terraform  script.
Local to aws cloud migration deployments.
Services: aws lambda, Ec2, S3 bucket, Secret Manager, Event Bridge, CloudWatch And IAM  rule.

create aws lambda function with runtime python
provide to access to s3 to get the files fro lambda
create lambda layers using some files in s3 bucket
provide access to the lambda to secret manager to get the secret values.
create an event bridge and schedule the lambda function  every 2 minutes to excute the lambda function and its create logs.

step function senario: if 2 lambda function  1 lambda will excutes after that step function will trigger 2nd lambda function


