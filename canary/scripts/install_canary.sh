#!/bin/bash
set -e

echo "Pulling Canary Docker images..."
docker pull schjonhaug/canary-backend:v1.3.0
docker pull schjonhaug/canary-frontend:v1.3.0

echo "Creating data directory..."
mkdir -p /mnt/hdd/mynode/canary
chown -R bitcoin:bitcoin /mnt/hdd/mynode/canary

echo "Installing frontend service..."
# The SDK only installs the main canary.service, so we install the frontend service here
cp /opt/mynode/custom_apps/canary/canary-frontend.service /etc/systemd/system/canary-frontend.service
systemctl daemon-reload
systemctl enable canary-frontend

echo "Canary installation complete."
