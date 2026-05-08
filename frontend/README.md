# 🎨 ScholarMate Frontend

ScholarMate는 AI 기반 개인 맞춤형 장학금 추천 서비스입니다.  
이 저장소는 ScholarMate v2의 프론트엔드(React + Vite) 프로젝트를 포함하고 있습니다.

프론트엔드는 Vercel에 배포되며,  
Django REST API 서버와 연동하여 동작합니다.

---

## 📌 프로젝트 개요

- 프로젝트명: ScholarMate Frontend
- 기술 스택: React (Vite), JavaScript, Tailwind CSS
- 배포: Vercel
- API 서버: Django REST Framework (AWS EC2)

---

## 🚀 주요 기능

- JWT 기반 로그인 / 회원가입
- 사용자 맞춤 장학금 추천
- 장학금 검색 및 필터링
- 관심 장학금 저장 기능
- 장학금 마감일 캘린더
- 커뮤니티 게시판
- 반응형 UI/UX

---

## 🛠 기술 스택

| 기술 | 설명 |
|------|------|
| React | UI 개발 라이브러리 |
| Vite | 빠른 개발 환경 및 번들링 |
| Tailwind CSS | 유틸리티 기반 CSS 프레임워크 |
| Axios | API 통신 |
| React Router | SPA 라우팅 |
| Vercel | 프론트엔드 배포 플랫폼 |

---

## 📁 프로젝트 구조

```text
frontend/
├── public/
├── src/
│   ├── api/                # Axios 및 API 관련 코드
│   ├── assets/             # 이미지 및 정적 자원
│   ├── components/         # 공통 컴포넌트
│   ├── data/               # 정적 데이터 / 상수 데이터
│   ├── mock/               # 목업 데이터
│   ├── pages/              # 페이지 컴포넌트
│   ├── routes/             # 라우팅 설정
│   ├── App.jsx             # 최상위 App 컴포넌트
│   └── main.jsx            # React 진입점
│
├── index.html
├── package.json
├── package-lock.json
├── postcss.config.js
├── tailwind.config.js
├── vercel.json
├── vite.config.js
└── README.md

⚙️ 실행 방법
1. 패키지 설치
npm install

2. 개발 서버 실행
npm run 

기본 실행 주소: http://localhost:

🌐 API 
환경변수 설정:
VITE_API_BASE_URL=https://api.scholarmate-v2.kro.kr
Axios는 /api 경로 기반으로 요청을 보내며,
Vercel rewrites를 통해 Django API 서버로 전달됩니다.

예시:

axios.get("/api/community/posts/")

🔄 API 요청 흐름
Frontend
   ↓
/api 요청
   ↓
Vercel rewrites
   ↓
https://api.scholarmate-v2.kro.kr

⚙️ Vercel Rewrite 설정
vercel.json
{
  "rewrites": [
    {
      "source": "/api/(.*)",
      "destination": "https://api.scholarmate-v2.kro.kr/api/$1"
    }
  ]
}
이를 통해 프론트엔드와 백엔드를 분리된 도메인 구조로 운영하면서도
안정적인 API 연결이 가능하도록 구성했습니다.

📦 빌드
npm run build

빌드 결과물:
frontend/dist/

🚀 배포
프론트엔드는 Vercel을 통해 자동 배포됩니다.
main branch push
    ↓
Vercel 자동 빌드
    ↓
Frontend 배포

📌 한 줄 요약
React + Vite 기반 프론트엔드를 Vercel에 배포하고,
Vercel rewrites를 통해 Django API 서버와 연결한 프로젝트

