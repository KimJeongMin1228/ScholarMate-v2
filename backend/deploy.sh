#!/bin/bash
set -e  # 에러 나면 즉시 중단

echo "Deploy Start"

cd ~/ScholarMate-v2/backend

echo "Pull latest code"
git fetch origin
git reset --hard origin/main

echo "Activate venv"
source venv/bin/activate

echo "Install dependencies"
pip install -r requirements.txt

echo "Run migrations"
python manage.py migrate

echo "Collect static"
python manage.py collectstatic --noinput

echo "Reload gunicorn (zero downtime)"
sudo systemctl reload gunicorn

echo "Deploy Done"
