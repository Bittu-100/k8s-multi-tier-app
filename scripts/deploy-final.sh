#!/bin/bash

echo "🚀 Final Deployment - Clean Setup"

# Clean up everything
echo "1. Cleaning up previous deployment..."
kubectl delete all -l app=multi-tier-app 2>/dev/null || true
kubectl delete pvc -l app=multi-tier-app 2>/dev/null || true
kubectl delete secret mysql-secrets 2>/dev/null || true

# Wait for cleanup
sleep 10

# Recreate secrets
echo "2. Creating MySQL secrets..."
kubectl create secret generic mysql-secrets \
  --from-literal=root-password=root123! \
  --from-literal=username=appuser \
  --from-literal=password=app123!

# Deploy database with fixed configuration
echo "3. Deploying Database..."
kubectl apply -f k8s/database/mysql-pvc.yaml
kubectl apply -f k8s/database/mysql-service.yaml
kubectl apply -f k8s/database/mysql-deployment-fixed.yaml

# Wait for database with longer timeout
echo "⏳ Waiting for database to be ready (this may take 2-3 minutes)..."
kubectl wait --for=condition=ready pod -l tier=database --timeout=240s

# Check database status
if kubectl get pod -l tier=database | grep -q Running; then
    echo "✅ Database is running!"
    kubectl logs -l tier=database --tail=5
else
    echo "❌ Database failed to start. Checking logs..."
    kubectl logs -l tier=database
    exit 1
fi

# Deploy backend and frontend
echo "4. Deploying Backend and Frontend..."
kubectl apply -f k8s/backend/
kubectl apply -f k8s/frontend/

# Wait for them to start
echo "⏳ Waiting for backend and frontend..."
sleep 30

kubectl wait --for=condition=available deployment/backend-deployment --timeout=120s
kubectl wait --for=condition=available deployment/frontend-deployment --timeout=120s

# Final status
echo "📊 Final Status:"
kubectl get pods -l app=multi-tier-app

echo "
🎉 Deployment Complete!
Access your application:
kubectl port-forward service/frontend-service 8080:80
Then visit: http://localhost:8080
"
