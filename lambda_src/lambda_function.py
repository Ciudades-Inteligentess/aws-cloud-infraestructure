import json

def lambda_handler(event, context):
    """Sample pure Lambda function"""

    print("Hello from Lambda!")
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
