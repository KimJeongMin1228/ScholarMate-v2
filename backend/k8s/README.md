# Kubernetes Manifests

이 디렉터리는 ScholarMate-v2를 Kubernetes 환경으로 마이그레이션하기 위한 Manifest를 관리합니다.

## Directory Structure

```text
k8s/
├── base/
└── overlays/
```

## Planned Resources

- Deployment
- Service
- ConfigMap
- Secret
- Ingress

향후 Kubernetes Manifest를 Helm Chart로 마이그레이션할 예정입니다.