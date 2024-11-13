# syntax=docker/dockerfile:1
FROM python:3.13-alpine as rye-app

WORKDIR /app
COPY requirements.lock ./
RUN PYTHONDONTWRITEBYTECODE=1 pip install --no-cache-dir -r requirements.lock

COPY api .
WORKDIR /app/api
CMD ["uvicorn", "main:app", "--reload"]