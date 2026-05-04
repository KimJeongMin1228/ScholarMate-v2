#!/bin/bash

echo "Deploy Start"

cd ~/ScholarMate-v2/backend

# 최신 코드
git pull origin main

# 가상환경
source venv/bin/activate

# 패키지
pip install -r requirements.txt

# 마이그레이션
python manage.py migrate

# static
python manage.py collectstatic --noinput

# gunicorn 재시작
sudo systemctl restart gunicorn

echo "Deploy Done"
