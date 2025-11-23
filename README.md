Multi-Tier Kubernetes Application
🚀 Project Overview
A complete 3-tier web application deployed on Kubernetes, featuring a Todo application with persistent data storage. This project demonstrates real-world microservices architecture, service communication, and production-ready Kubernetes deployment practices.
🏗️ Architecture
text
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
Components:
•	Frontend: nginx serving static web interface with JavaScript
•	Backend: Node.js Express API handling business logic
•	Database: MySQL with persistent storage for data persistence
📁 Project Structure
text
k8s-multi-tier-app/
├── k8s/                    # Kubernetes manifests
│   ├── database/          # MySQL deployment, service, PVC, secrets
│   ├── backend/           # Node.js API deployment & service
│   ├── frontend/          # nginx deployment & service
│   └── configs/           # Shared configurations
├── src/                   # Application source code
│   ├── backend/           # Node.js Express API
│   │   ├── server.js      # Main application logic
│   │   ├── package.json   # Dependencies
│   │   └── Dockerfile     # Backend container definition
│   └── frontend/          # Web interface
│       ├── index.html     # Web application UI
│       ├── nginx.conf     # nginx configuration
│       └── Dockerfile     # Frontend container definition
├── scripts/               # Deployment & utility scripts
│   ├── deploy-all.sh      # Complete deployment script
│   ├── deploy-final.sh    # Fixed deployment script
│   ├── test-app.sh        # Application testing
│   └── setup-git.sh       # Git configuration helper
├── docs/                  # Documentation
│   ├── images/            # Screenshots & diagrams
│   ├── CHALLENGES.md      # Problems solved & learnings
│   └── architecture.md    # Detailed architecture
├── README.md              # This file
└── .gitignore            # Git ignore rules
🛠️ Technologies Used
•	Kubernetes: Container orchestration
•	Docker: Containerization
•	Node.js: Backend runtime
•	Express.js: Web framework
•	MySQL: Database management
•	nginx: Web server & reverse proxy
•	Git: Version control
🚀 Quick Start
Prerequisites
•	Kubernetes cluster (Minikube recommended)
•	kubectl configured
•	Docker
Deployment Steps
1.	Clone and setup:
bash
git clone https://github.com/YOUR_USERNAME/k8s-multi-tier-app.git
cd k8s-multi-tier-app
2.	Build Docker images:
bash
# Switch to Minikube's Docker environment
eval $(minikube docker-env)

# Build backend image
docker build -t multi-tier-backend:1.0.0 src/backend/

# Build frontend image
docker build -t multi-tier-frontend:1.0.0 src/frontend/
3.	Deploy to Kubernetes:
bash
# Run the complete deployment script
./scripts/deploy-final.sh

# Or deploy manually:
kubectl apply -f k8s/database/
kubectl apply -f k8s/backend/
kubectl apply -f k8s/frontend/
4.	Access the application:
bash
# Access web interface
kubectl port-forward service/frontend-service 8080:80
# Visit: http://localhost:8080

# Access backend API
kubectl port-forward service/backend-service 3000:3000
# API available at: http://localhost:3000
📊 Application Features
✅ Core Functionality
•	Add new tasks with titles and descriptions
•	View all tasks in a clean interface
•	Persistent data storage (tasks survive pod restarts)
•	Real-time system status monitoring
•	Health checks and auto-recovery
✅ Kubernetes Features Implemented
•	Multi-container pod management
•	Service discovery and load balancing
•	Persistent Volume Claims (PVC) for data storage
•	Secrets management for sensitive data
•	Liveness and readiness probes
•	Resource limits and requests
•	Rolling updates configuration
🔧 API Endpoints
Backend API (Port 3000)
•	GET /health - Service health check
•	GET /api/tasks - Retrieve all tasks
•	POST /api/tasks - Create new task
•	GET /api/info - System information
Frontend (Port 80)
•	GET / - Web application interface
•	GET /health - Frontend health check
•	GET /api/* - Proxied to backend service
🎯 Kubernetes Resources Deployed
Deployments
•	frontend-deployment (2 replicas) - nginx web server
•	backend-deployment (2 replicas) - Node.js API
•	mysql-deployment (1 replica) - MySQL database
Services
•	frontend-service (NodePort:30080) - External access
•	backend-service (ClusterIP) - Internal API access
•	mysql-service (ClusterIP) - Database access
Storage & Configuration
•	mysql-pvc - Persistent Volume Claim (5Gi)
•	mysql-secrets - Database credentials
•	ConfigMaps for application configuration
🚧 Challenges & Solutions
Major Challenges Overcome:
1.	MySQL Authentication Issues
o	Problem: Readiness probes failing due to authentication errors
o	Solution: Fixed secret management and TCP-based health checks
2.	Docker Image Deployment
o	Problem: ImagePullBackOff errors in Minikube
o	Solution: Built images in Minikube's Docker environment
3.	Service Communication
o	Problem: Backend couldn't connect to database
o	Solution: Proper service discovery and environment variables
4.	Persistent Storage
o	Problem: Data loss on pod restarts
o	Solution: Implemented Persistent Volume Claims
Key Learnings:
•	Kubernetes secret management best practices
•	Database initialization timing in containers
•	Service discovery patterns in microservices
•	Health probe configuration for stateful services
•	Minikube-specific deployment considerations
📈 Performance & Metrics
Deployment Performance:
•	Initial deployment time: 8-10 minutes
•	Redeployment time: 3-4 minutes
•	Database initialization: 2-3 minutes
•	Application startup: 30-60 seconds
Resource Usage:
•	Frontend: 64Mi memory, 50m CPU per pod
•	Backend: 128Mi memory, 100m CPU per pod
•	Database: 256Mi memory, 100m CPU
Availability:
•	Health checks: Automatic pod restart on failures
•	Readiness probes: Traffic only sent to healthy pods
•	Liveness probes: Automatic recovery from deadlocks
•	Data persistence: Survives pod crashes and restarts


