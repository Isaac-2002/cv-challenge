# Visitor Tracker App

A full-stack serverless application built with AWS SAM that tracks website visits and displays real-time visitor counts. This project demonstrates a modern cloud architecture using AWS Lambda, API Gateway, DynamoDB, S3, and CloudFront.

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   CloudFront    │───▶│   S3 Bucket     │    │   API Gateway   │
│   (CDN)         │    │   (Frontend)    │    │   (REST API)    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                                       │
                                              ┌─────────────────┐
                                              │  Lambda Functions│
                                              │  - Track Visits │
                                              │  - Get Count    │
                                              └─────────────────┘
                                                       │
                                              ┌─────────────────┐
                                              │   DynamoDB      │
                                              │  (Visit Data)   │
                                              └─────────────────┘
```

## 📁 Project Structure

```
/visitor-tracker-app
├── frontend/
│   ├── index.html          # Static website files
│   ├── template.yaml       # CloudFront + S3 infrastructure
│   └── samconfig.toml      # Frontend SAM configuration
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

This project uses AWS SAM (Serverless Application Model) for infrastructure as code and GitHub Actions for CI/CD.

### Prerequisites

- AWS CLI configured with appropriate permissions
- SAM CLI installed
- GitHub repository with AWS credentials configured as secrets:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`

### Automatic Deployment

The application deploys automatically via GitHub Actions:

- **Backend**: Triggers on changes to `backend/` directory
- **Frontend**: Triggers on changes to `frontend/` directory

### Manual Deployment

#### Backend (Lambda + API + DynamoDB)
```bash
cd backend
sam build
sam deploy --config-env backend
```

#### Frontend (S3 + CloudFront)
```bash
cd frontend
sam build
sam deploy --config-env frontend
```

## 🛠️ Development

### Local Testing

Test Lambda functions locally:
```bash
cd backend
sam build
sam local start-api
```

### Backend Functions

- `TrackVisitsFunction`: Records visitor data in DynamoDB
- `GetVisitCountFunction`: Retrieves current visit count

### Frontend

Static HTML website served via CloudFront with HTTPS certificate and caching optimization.

## 🔧 Configuration

### Environment Variables

Backend functions use environment variables for:
- DynamoDB table names
- CORS settings
- API Gateway configuration

### Tags

All resources are tagged with:
- Project: CV-Challenge
- Environment: Production
- Owner: Isaac-Hasbani
- Cost Center: Personal
- Purpose: Portfolio-Website

## 📊 Monitoring

- CloudWatch logs for Lambda functions
- CloudFront metrics for frontend performance
- DynamoDB metrics for database operations

## 🔐 Security

- S3 bucket with public access blocked (served via CloudFront)
- Lambda functions with minimal IAM permissions
- API Gateway with CORS configured
- CloudFront with HTTPS enforcement

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test locally
5. Submit a pull request

## 📝 License

This project is part of a portfolio and is intended for demonstration purposes. 

## 📅 Last Updated

Last updated: March 2024 