# CV with Visitor Tracker

A simple serverless application built to get familiar with AWS services and serverless architecture. The application displays a CV website and tracks the number of visits using AWS Lambda, API Gateway, DynamoDB, S3, and CloudFront.

## 📁 Project Structure

```
├── frontend/
│   ├── index.html          # Static CV website
│   ├── template.yaml       # CloudFront + S3 infrastructure
│   ├── samconfig.toml      # Frontend SAM configuration
│   └── quick-deploy.sh     # Fast deployment script for content changes
│
├── backend/
│   ├── track_visits/       # Lambda function to track visits
│   ├── get_visit_count/    # Lambda function to get visit count
│   ├── template.yaml       # Lambda + API + DynamoDB infrastructure
│   └── samconfig.toml      # Backend SAM configuration
│
├── samconfig.toml          # Master SAM configuration
├── .github/
│   └── workflows/
│       ├── deploy-frontend.yml  # Frontend CI/CD pipeline
│       └── deploy-backend.yml   # Backend CI/CD pipeline
└── README.md
```

## 🚀 Deployment

### Prerequisites

- AWS CLI configured with appropriate permissions
- SAM CLI installed

### Local Deployment

Deploy the complete stack:

```bash
# Deploy backend
cd backend
sam build && sam deploy

# Deploy frontend
cd ../frontend
sam build && sam deploy
```

For quick content updates (index.html only):
```bash
cd frontend
./quick-deploy.sh
```

### CI/CD Deployment

The application deploys automatically via GitHub Actions when pushing to the `main` branch:

- **Backend**: Triggers on changes to `backend/` directory
- **Frontend**: Triggers on changes to `frontend/` directory

Set up GitHub repository secrets:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

### Local Testing

Test Lambda functions locally:
```bash
cd backend
sam build
sam local start-api
```

## Architecture

*Architecture diagram will be added here* 