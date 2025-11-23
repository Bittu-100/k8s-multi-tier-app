#!/bin/bash

echo "🚀 Deploying Multi-Tier Application..."

# Apply database resources
echo "Deploying database..."
kubectl apply -f k8s/database/

# Wait for database to be ready
echo "Waiting for database..."
kubectl wait --for=condition=ready pod -l tier=database --timeout=120s

# Apply backend
echo "Deploying backend..."
kubectl apply -f k8s/backend/

# Apply frontend
echo "Deploying frontend..."
kubectl apply -f k8s/frontend/

# Wait for all deployments
echo "Waiting for all services to be ready..."
kubectl wait --for=condition=available deployment/frontend-deployment --timeout=180s
kubectl wait --for=condition=available deployment/backend-deployment --timeout=180s

# Display status
echo "📊 Deployment Status:"
kubectl get deployments -l app=multi-tier-app
kubectl get services -l app=multi-tier-app
kubectl get pods -l app=multi-tier-app

echo "
✅ Multi-tier application deployed!

🌐 Access Methods:
1. Frontend (Web UI): 
   kubectl port-forward service/frontend-service 8080:80
   Then visit: http://localhost:8080

2. Backend API:
   kubectl port-forward service/backend-service 3000:3000
   API available at: http://localhost:3000

3. Direct NodePort:
   http://$(minikube ip):30080
"
