#!/bin/bash
set -e

echo "Pulling Canary Docker images..."
docker pull schjonhaug/canary-backend:v1.3.0
docker pull schjonhaug/canary-frontend:v1.3.0

echo "Creating data directory..."
mkdir -p /mnt/hdd/mynode/canary
chown -R bitcoin:bitcoin /mnt/hdd/mynode/canary

echo "Creating start script..."
cat > /opt/mynode/canary/start_canary.sh << 'SCRIPT'
#!/bin/bash
set -e

# Stop and remove any existing containers
docker stop canary canary-frontend 2>/dev/null || true
docker rm canary canary-frontend 2>/dev/null || true

# Start backend container
docker run -d --name canary \
    --network host \
    -v /mnt/hdd/mynode/canary:/app/data \
    -e CANARY_DATA_DIR=/app/data \
    -e CANARY_ELECTRUM_URL=ssl://127.0.0.1:50002 \
    -e CANARY_NETWORK=mainnet \
    -e CANARY_MODE=self-hosted \
    -e CANARY_BIND_ADDRESS=0.0.0.0:3010 \
    schjonhaug/canary-backend:v1.3.0

# Wait for backend to be ready
sleep 2

# Start frontend container
docker run -d --name canary-frontend \
    --network host \
    -e API_URL=http://127.0.0.1:3010 \
    -e PORT=3005 \
    schjonhaug/canary-frontend:v1.3.0

echo "Canary started successfully"
SCRIPT
chmod +x /opt/mynode/canary/start_canary.sh

echo "Canary installation complete."
