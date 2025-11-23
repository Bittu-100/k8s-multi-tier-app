#!/bin/bash

echo "🔨 Building Docker images..."

# Build backend image
echo "Building backend image..."
docker build -t multi-tier-backend:1.0.0 src/backend/

# Build frontend image  
echo "Building frontend image..."
docker build -t multi-tier-frontend:1.0.0 src/frontend/

echo "✅ Images built successfully!"
