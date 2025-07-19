import json
import boto3
import os
import logging

# Configure logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(os.environ['TABLE_NAME'])

def lambda_handler(event, context):
    try:
        logger.info("Getting visitor count")
        response = table.scan(Select='COUNT')
        count = response['Count']
        
        logger.info(f"Current visitor count: {count}")
        
        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps({'count': count})
        }
    except Exception as e:
        logger.error(f"Error getting visitor count: {str(e)}")
        return {
            'statusCode': 500,
            'headers': {
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps({'error': 'Internal server error'})
        }