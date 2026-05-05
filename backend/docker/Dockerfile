FROM python:3.10-slim
# 작업 디렉토리
WORKDIR /app

# 시스템 패키지
RUN apt-get update && apt-get install -y \
    build-essential \
    default-libmysqlclient-dev \
    pkg-config \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn

# 프로젝트 복사
COPY . .

# collectstatic
RUN python manage.py collectstatic --noinput

# 실행
CMD ["gunicorn", "ScholarMate_backend.wsgi:application", "--bind", "0.0.0.0:8000"]