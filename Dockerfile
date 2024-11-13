# syntax=docker/dockerfile:1
FROM python:3.13-alpine as uv-app

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

COPY /uv.lock /pyproject.toml ./
RUN uv sync --frozen --no-cache --no-dev

WORKDIR /api
COPY ./api .
CMD ["uv", "run", "uvicorn", "main:app"]
