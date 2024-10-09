# lambda_function.py

import json

def lambda_handler(event, context):
    print("Event Received:", event)
    
    # Simple response for the Lambda function
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Python Lambda!')
    }
