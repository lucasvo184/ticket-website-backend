#!/bin/bash

# Build Docker image
echo "Building Docker image..."
docker build -t ticket-booking-backend .

# Stop and remove existing container if exists
echo "Cleaning up existing container..."
docker stop ticket-booking-backend || true
docker rm ticket-booking-backend || true

# Run new container
echo "Starting new container..."
docker run -d \
  -p 8080:8080 \
  -e DB_HOST=mysql.railway.internal \
  -e DB_PORT=3306 \
  -e DB_NAME=railway \
  -e DB_USERNAME=root \
  -e DB_PASSWORD=ZhwzvRiaSTHJutpjaNcbGNRzhhshDUYn \
  --name ticket-booking-backend \
  ticket-booking-backend

# Wait for application to start
echo "Waiting for application to start..."
sleep 30

# Check container status
echo "Container status:"
docker ps | grep ticket-booking-backend

# Check logs
echo "Container logs:"
docker logs ticket-booking-backend

# Check health endpoint
echo "Health check:"
curl http://localhost:8080/actuator/health 