# 🎓 ScholarMate v2

AI 기반 개인 맞춤형 장학금 추천 서비스 (Production Deployment Version)

`ScholarMate v2`는 기존 프로젝트를 실제 서비스 운영 환경 수준으로 개선한 버전으로,  
프론트/백엔드 분리, Docker 기반 배포, HTTPS, CI/CD 자동화를 포함한 풀스택 인프라 프로젝트입니다.

---

## 🚀 배포 링크

- 🌐 Frontend: https://scholar-mate-v2.vercel.app
- 🔗 Backend API: https://api.scholarmate-v2.kro.kr

---

## 📌 주요 기능

- AI 기반 장학금 추천 (사용자 조건 분석)
- JWT 인증 (로그인 / 회원가입)
- 관심 장학금 저장 기능
- 장학금 마감일 관리 (캘린더)
- 커뮤니티 게시판
- MySQL 기반 데이터 필터링
- RESTful API 설계

---

## 🛠 기술 스택

| 파트 | 기술 |
|------|------|
| 프론트엔드 | React (Vite), Tailwind CSS, Axios |
| 백엔드 | Django, Django REST Framework, JWT |
| DB | AWS RDS (MySQL) |
| 캐시 | Redis |
| 배포 | AWS EC2, Docker, Nginx |
| CI/CD | GitHub Actions |
| 도메인 | kro.kr |

---

## 🧱 아키텍처

```text
[ Client ]
     ↓
[ Vercel (Frontend) ]
     ↓ (/api 요청)
[ Vercel Rewrites ]
     ↓
https://api.scholarmate-v2.kro.kr
     ↓
[ EC2 Nginx (HTTPS / SSL Termination) ]
     ↓
[ Docker Nginx (Reverse Proxy) ]
     ↓
[ Django + Gunicorn Container ]
     ↓
[ Redis Container ]
     ↓
[ AWS RDS (MySQL) ]

🔄 요청 흐름
1. 사용자가 Vercel 프론트엔드 접속
2. /api 요청 발생
3. Vercel rewrites를 통해 API 서버로 전달
4. EC2 Nginx에서 HTTPS 처리
5. Docker 내부 Nginx가 Django로 요청 전달
6. Django → DB / Redis 처리 후 응답 반환

⚙️ CI/CD 파이프라인
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
코드 변경 시 자동으로 배포됩니다.

🔐 HTTPS 적용
1. Let’s Encrypt + Certbot 사용
2. EC2 Nginx에서 SSL Termination 처리
3. HTTP → HTTPS 리다이렉트 구성

📁 프로젝트 구조
ScholarMate-v2/
├── .github/
│   └── workflows/
│       └── deploy.yml                # GitHub Actions CI/CD 설정
│
├── backend/
│   ├── accounts/                     # 사용자 인증 앱
│   ├── community/                    # 커뮤니티 게시판 앱
│   ├── contact/                      # 문의/연락 관련 앱
│   ├── notices/                      # 공지사항 앱
│   ├── scholarships/                 # 장학금 추천/조회 앱
│   ├── userinfor/                    # 사용자 정보 앱
│   │
│   ├── ScholarMate_backend/          # Django 프로젝트 설정
│   │   ├── settings.py
│   │   ├── urls.py
│   │   ├── wsgi.py
│   │   └── asgi.py
│   │
│   ├── docker/                       # Docker 및 Nginx 설정
│   │   ├── Dockerfile
│   │   ├── docker-compose.yml
│   │   └── nginx/
│   │       └── default.conf
│   │
│   ├── staticfiles/                  # collectstatic 결과물
│   ├── deploy.sh                     # EC2 배포 스크립트
│   ├── manage.py
│   ├── requirements.txt
│   └── README.md
│
├── frontend/
│   ├── public/                       # 정적 파일
│   ├── src/
│   │   ├── api/                      # Axios 및 API 관련 코드
│   │   ├── assets/                   # 이미지 및 정적 자원
│   │   ├── components/               # 공통 컴포넌트
│   │   ├── data/                     # 정적 데이터 / 상수 데이터
│   │   ├── mock/                     # 목업 데이터
│   │   ├── pages/                    # 페이지 컴포넌트
│   │   ├── routes/                   # 라우팅 설정
│   │   ├── App.jsx                   # 최상위 App 컴포넌트
│   │   └── main.jsx                  # React 진입점
│   │
│   ├── index.html
│   ├── package.json
│   ├── package-lock.json
│   ├── postcss.config.js
│   ├── tailwind.config.js
│   ├── vercel.json                   # Vercel rewrites 설정
│   ├── vite.config.js
│   └── README.md
│
├── .gitignore
└── README.md                         # 프로젝트 전체 설명

💡 기술 선택 이유
1. Nginx
- Reverse Proxy 역할
- HTTPS 처리 (SSL termination)
- 트래픽 관리
2. Docker
- 환경 일관성 확보
- 배포 자동화
- 서비스 분리 (Django / Redis / Nginx)
3. Redis
- 캐싱 처리
- 향후 비동기 작업 확장 가능
4. Vercel
- 프론트엔드 배포 최적화
- CDN 기반 빠른 응답

🔥 트러블슈팅
1. Let's Encrypt Rate Limit
문제: 인증서 발급 제한 발생
해결: staging 인증서 → real 인증서 교체

2. Mixed Content (HTTPS 경고)
문제: HTTP 요청 포함
해결: 모든 API 요청을 HTTPS로 통일

3. Docker 빌드 오류
문제: mysqlclient / pkg-config 오류
해결: 시스템 패키지 설치

4. CI/CD 실패 (gunicorn reload)
문제: Docker 전환 후 systemctl 사용
해결: deploy.sh 

👥 팀원
박해준 (프론트엔드)
김정민 (백엔드 / 인프라)

🎯 프로젝트 성과

단순 웹 서비스 구현을 넘어 실제 운영 가능한 인프라 환경 구축을 목표로 개발

- Docker 기반 서비스 구성
- AWS EC2 운영 경험
- HTTPS / 도메인 연결
- CI/CD 자동 배포 구축
- 프론트/백엔드 분리 구조

📌 향후 개선
- 무중단 배포 (Blue-Green)
- AWS Load Balancer 적용
- 모니터링 (Prometheus / Grafana)
- 로그 수집 (ELK)

📌 한 줄 요약

Django 기반 서비스를 Docker, Nginx, AWS,9 CI/CD까지 포함해 실제 운영 환경으로 배포한 프로젝트