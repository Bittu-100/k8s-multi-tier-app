# Multi-Tier Kubernetes Application

🎯 Project Architecture

┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Frontend      │    │   Backend API    │    │   Database      │
│   (nginx)       │◄───│   (Node.js)      │◄───│   (MySQL)       │
│   Port: 80      │    │   Port: 3000     │    │   Port: 3306    │
└─────────────────┘    └──────────────────┘    └─────────────────┘
        │                       │                       │
        ▼                       ▼                       ▼
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Frontend      │    │   Backend        │    │   Database      │
│   Service       │    │   Service        │    │   Service       │
│   NodePort:30080│    │   ClusterIP:3000 │    │   ClusterIP:3306│
└─────────────────┘    └──────────────────┘    └─────────────────┘


A three-tier web application demonstrating microservices architecture on Kubernetes:

- **Frontend**: nginx serving static content and proxying API requests
- **Backend**: Node.js Express API with MySQL database
- **Database**: MySQL with persistent storage

## 🚀 Quick Start
```bash
# Build images
./scripts/build-images.sh

# Deploy to Kubernetes
./scripts/deploy.sh


📁 Project Structure

k8s-multi-tier-app/
├── k8s/
│   ├── frontend/          # Frontend deployment & service
│   ├── backend/           # Backend API deployment & service  
│   ├── database/          # Database deployment & service
│   └── configs/           # Shared configurations
├── src/
│   ├── frontend/          # nginx configs, static files
│   └── backend/           # Node.js application code
├── database/
│   └── init-scripts/      # DB initialization
├── scripts/               # Deployment scripts
├── docs/                  # Documentation
└── README.md

🛠️ Technologies
Kubernetes

Docker

Node.js + Express

MySQL

nginx



## Prerequisites
Kubernetes cluster (Minikube recommended)

kubectl configured

Docker



## Deployment Steps

1. Clone and setup:

git clone https://github.com/YOUR_USERNAME/k8s-multi-tier-app.git
cd k8s-multi-tier-app


2. Build Docker images:

# Switch to Minikube's Docker environment
eval $(minikube docker-env)

# Build backend image
docker build -t multi-tier-backend:1.0.0 src/backend/

# Build frontend image
docker build -t multi-tier-frontend:1.0.0 src/frontend/

3. Deploy to Kubernetes:

# Run the complete deployment script
./scripts/deploy-final.sh

# Or deploy manually:
kubectl apply -f k8s/database/
kubectl apply -f k8s/backend/
kubectl apply -f k8s/frontend/

4. Access the application:

# Access web interface
kubectl port-forward service/frontend-service 8080:80
# Visit: http://localhost:8080

# Access backend API
kubectl port-forward service/backend-service 3000:3000
# API available at: http://localhost:3000
