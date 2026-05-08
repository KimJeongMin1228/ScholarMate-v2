# 🎓 ScholarMate Backend

ScholarMate는 AI 기반 개인 맞춤형 장학금 추천 서비스입니다.  
이 저장소는 ScholarMate v2의 백엔드(Django REST API) 프로젝트를 포함하고 있습니다.

백엔드는 AWS EC2 환경에서 Docker 기반으로 운영되며,  
Nginx + Gunicorn + Redis + RDS(MySQL) 구조로 구성되어 있습니다.

---

## ⚙️ 개발 환경

| 항목 | 버전 / 환경 |
|------|-------------|
| OS | Ubuntu 24.04 LTS |
| Language | Python 3.12 |
| Framework | Django 5.x |
| API | Django REST Framework |
| Database | AWS RDS (MySQL) |
| Cache | Redis |
| Web Server | Nginx |
| Application Server | Gunicorn |
| Containerization | Docker / Docker Compose |
| CI/CD | GitHub Actions |

---

## 📌 프로젝트 개요

- 프로젝트명: ScholarMate Backend
- 기술 스택: Django, DRF, MySQL, Redis, Docker, AWS
- 배포 환경: AWS EC2
- 주요 기능:
  - JWT 기반 로그인 / 회원가입
  - 장학금 데이터 저장 및 관리
  - AI 기반 장학금 추천 시스템
  - 사용자 맞춤 필터링 기능
  - RESTful API 제공
  - 커뮤니티 게시판 기능

---

## 🛠 기술 스택

| 기술 | 설명 |
|------|------|
| Django | Python 기반 웹 프레임워크 |
| Django REST Framework | RESTful API 구축 |
| MySQL (RDS) | 관계형 데이터베이스 |
| JWT (Simple JWT) | 사용자 인증 |
| Redis | 캐시 및 확장 가능한 비동기 처리 기반 |
| Gunicorn | Django WSGI 서버 |
| Nginx | Reverse Proxy 및 HTTPS 처리 |
| Docker | 컨테이너 기반 배포 환경 |
| GitHub Actions | CI/CD 자동 배포 |

---

## 📁 프로젝트 구조

```text
backend/
├── accounts/                     # 사용자 인증 앱
├── community/                    # 커뮤니티 게시판 앱
├── contact/                      # 문의/연락 관련 앱
├── notices/                      # 공지사항 앱
├── scholarships/                 # 장학금 추천/조회 앱
├── userinfor/                    # 사용자 정보 앱
│
├── ScholarMate_backend/          # Django 프로젝트 설정
│   ├── settings.py
│   ├── urls.py
│   ├── wsgi.py
│   └── asgi.py
│
├── docker/
│   ├── Dockerfile
│   ├── docker-compose.yml
│   └── nginx/
│       └── default.conf
│
├── staticfiles/                  # collectstatic 결과물
├── deploy.sh                     # EC2 자동 배포 스크립트
├── manage.py
├── requirements.txt
└── README.md

🧱 서버 아키텍처
Client
   ↓
Vercel Frontend
   ↓
EC2 Nginx (HTTPS)
   ↓
Docker Nginx
   ↓
Django + Gunicorn
   ↓
Redis / RDS(MySQL)

🐳 Docker 구성

Docker Compose 기반 멀티 컨테이너 구조

서비스 구성
1. django
- Django + Gunicorn 실행
2. nginx
- Reverse Proxy 역할
3. redis
- 캐시 서버

⚙️ 실행 방법
1. 패키지 설치
pip install -r requirements.txt

2. 개발 서버 실행
python manage.py runserver

기본 실행 주소:
http://127.0.0.1:8000

🐳 Docker 실행
1. 컨테이너 실행
docker-compose -f docker/docker-compose.yml up --build -d

2. 컨테이너 확인
docker ps

🔐 HTTPS 적용
- Let’s Encrypt + Certbot 사용
- EC2 Host Nginx에서 SSL Termination 처리
- HTTP → HTTPS 리다이렉트 구성

⚙️ CI/CD
GitHub Actions를 통해 자동 배포됩니다.
git push (main)
    ↓
GitHub Actions
    ↓
EC2 SSH 접속
    ↓
git pull
    ↓
docker-compose up --build -d
    ↓
Nginx reload

🌐 API 서버 주소
https://api.scholarmate-v2.kro.kr

🔥 트러블슈팅
1. Let's Encrypt Rate Limit
- 문제: 인증서 발급 제한 발생
- 해결: staging 인증서 사용 후 real 인증서로 교체

2. Docker mysqlclient 빌드 오류
- 문제: pkg-config 관련 오류 발생
- 해결: 시스템 패키지 설치 후 빌드 진행
3. CI/CD 배포 실패
- 문제: Docker 전환 후 gunicorn.service reload 오류
- 해결: deploy.sh 수정
4. Mixed Content (HTTPS 경고)
- 문제: HTTP 요청 포함
- 해결: API 요청을 HTTPS로 통일

📌 한 줄 요약
Django REST API 서버를 Docker, Nginx, Redis, AWS EC2 기반으로 구성하고,
GitHub Actions를 통해 자동 배포(CI/CD)까지 구축한 프로젝트