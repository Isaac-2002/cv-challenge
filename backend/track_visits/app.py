import json
import boto3
import os
from datetime import datetime

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(os.environ['TABLE_NAME'])

def lambda_handler(event, context):
    ip = event['requestContext']['identity']['sourceIp']
    user_agent = event['headers'].get('User-Agent', 'Unknown')

    table.put_item(Item={
        'timestamp': datetime.utcnow().isoformat(),
        'ip': ip,
        'user_agent': user_agent
    })

    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Origin': '*'
        },
        'body': json.dumps({'message': 'Visit recorded'})
    }# Test comment
