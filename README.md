# Multi-Tier Kubernetes Application

## 🏗️ Architecture
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
