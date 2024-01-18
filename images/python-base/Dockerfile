# > An ARG declared before a FROM is outside of a build stage, so it can't be used in any instruction after a FROM
# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact

# Specify "base" Python image e.g., "3.10"
ARG PYTHON_VERSION

FROM python:${PYTHON_VERSION}-slim as python-base-BASE

# For tracking deployed images later e.g., 2024.01.17.15.09.31
ARG TIMESTAMP

    # Python
ENV PYTHONUNBUFFERED=1 \
    # prevents python creating .pyc files
    PYTHONDONTWRITEBYTECODE=1 \
    # pip
    PIP_NO_CACHE_DIR=yes \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    \
    # Poetry
    # do not ask any interactive question
    POETRY_NO_INTERACTION=1 \
    # never create virtual environment automaticly, only use env prepared by us
    POETRY_VIRTUALENVS_CREATE=false \
    # Update PATH to include pipx defautl
    PATH="/root/.local/bin:${PATH}"

# Install pipx. pipx installs Python CLI programs in an isolated environment
# in addition it makes the CLI entry points available on $PATH
RUN pip install --upgrade pipx

# Install poetry via pipx
# https://python-poetry.org/docs/#installing-with-pipx
RUN pipx install poetry

# Leave a note behind so we can always quickly determine our original image
RUN echo "${TIMESTAMP}" > /docker-tag
