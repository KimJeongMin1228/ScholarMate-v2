#!/bin/bash
set -e

KUBECONFIG_PATH="/etc/rancher/k3s/k3s.yaml"
CHART_PATH="backend/helm/scholarmate"
NAMESPACE="prod"
RELEASE_NAME="scholarmate"

echo "==============================="
echo "ScholarMate Helm Deploy Start"
echo "==============================="

cd ~/ScholarMate-v2

echo "[1/5] Pull latest code"
git fetch origin
git reset --hard origin/main

echo "[2/5] Helm lint"
helm lint "$CHART_PATH"

echo "[3/5] Helm upgrade"
sudo helm upgrade --install "$RELEASE_NAME" \
  "$CHART_PATH" \
  --namespace "$NAMESPACE" \
  --kubeconfig "$KUBECONFIG_PATH" \
  --wait \
  --timeout 5m

echo "[4/5] Rollout status"
sudo kubectl rollout status deployment/scholarmate-django \
  --namespace "$NAMESPACE" \
  --kubeconfig "$KUBECONFIG_PATH" \
  --timeout=180s

echo "[5/5] Deploy complete"
sudo helm list \
  --namespace "$NAMESPACE" \
  --kubeconfig "$KUBECONFIG_PATH"