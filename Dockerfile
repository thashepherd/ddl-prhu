# syntax=docker/dockerfile:1
# Build with docker build -f Dockerfile_2 -t version_2 .
# Run with docker run -p 8000:8000 version_2
FROM python:3.12-alpine as my-app

ENV VENV_PATH="/.venv" \
    POETRY_VERSION=1.8.4 \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_VIRTUALENVS_OPTIONS_NO_PIP=true \
    POETRY_VIRTUALENVS_OPTIONS_NO_SETUPTOOLS=true

ENV PATH="$VENV_PATH/bin:$PATH"

RUN apk add --no-cache poetry

COPY /poetry.lock /pyproject.toml ./
RUN poetry install --only main --no-root --no-directory -n

WORKDIR /api
COPY ./api .
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
