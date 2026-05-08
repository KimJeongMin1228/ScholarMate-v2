#!/bin/bash
set -e

echo "Docker Deploy Start"

cd ~/ScholarMate-v2/backend

echo "Pull latest code"
git fetch origin
git reset --hard origin/main

echo "Build and run containers (zero downtime)"
docker compose -f docker/docker-compose.yml up --build -d

echo "Check containers"
docker ps

echo "Reload nginx"
sudo nginx -t
sudo systemctl reload nginx

echo "Docker Deploy Done"
