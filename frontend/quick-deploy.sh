#!/bin/bash
set -e

echo "🚀 Quick Deploy - Content Update Only"
echo "======================================"

# Check if we're in the frontend directory
if [ ! -f "index.html" ]; then
    echo "❌ Error: index.html not found. Make sure you're running this from the frontend directory."
    exit 1
fi

echo "📡 Getting S3 bucket name from CloudFormation stack..."
BUCKET_NAME=$(aws cloudformation describe-stacks \
    --stack-name cv-frontend \
    --region eu-west-2 \
    --query 'Stacks[0].Outputs[?OutputKey==`CVWebsiteBucket`].OutputValue' \
    --output text 2>/dev/null)

if [ -z "$BUCKET_NAME" ] || [ "$BUCKET_NAME" = "None" ]; then
    echo "❌ Error: Could not find S3 bucket. Make sure:"
    echo "   1. AWS CLI is configured"
    echo "   2. cv-frontend stack is deployed"
    echo "   3. You have the right permissions"
    exit 1
fi

echo "✅ Found S3 bucket: $BUCKET_NAME"

echo "📤 Uploading index.html to S3..."
aws s3 cp index.html "s3://${BUCKET_NAME}/index.html" \
    --cache-control "no-cache" \
    --region eu-west-2

echo "🌩️  Getting CloudFront distribution ID..."
CLOUDFRONT_ID=$(aws cloudformation describe-stacks \
    --stack-name cv-frontend \
    --region eu-west-2 \
    --query 'Stacks[0].Outputs[?OutputKey==`CloudFrontDistributionId`].OutputValue' \
    --output text 2>/dev/null)

if [ -n "$CLOUDFRONT_ID" ] && [ "$CLOUDFRONT_ID" != "None" ]; then
    echo "⚡ Creating CloudFront cache invalidation..."
    INVALIDATION_ID=$(aws cloudfront create-invalidation \
        --distribution-id "$CLOUDFRONT_ID" \
        --paths "/*" \
        --query 'Invalidation.Id' \
        --output text)
    
    echo "✅ CloudFront invalidation created: $INVALIDATION_ID"
    echo "🕐 Changes should be visible within 1-3 minutes"
else
    echo "⚠️  Warning: Could not find CloudFront distribution ID"
    echo "   File uploaded to S3, but cache may need manual invalidation"
fi

echo ""
echo "🎉 Quick deploy completed successfully!"
echo "💡 Your website should update soon at: https://www.isaachasbani.com"
echo "" 