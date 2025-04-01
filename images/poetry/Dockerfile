# > An ARG declared before a FROM is outside of a build stage, so it can't be used in any instruction after a FROM
# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact

# Specify "base" Python image e.g., "3.10" with default set here
ARG PYTHON_VERSION="3.10"

# For tracking deployed images later e.g., 2024.01.17.15.09.31 with default set here
ARG TIMESTAMP="2025"

FROM python:${PYTHON_VERSION}-slim

#
# Python base config
#
ENV PYTHONUNBUFFERED=1
# prevents python creating .pyc files
ENV PYTHONDONTWRITEBYTECODE=1

#
# pip base config
#
ENV PIP_NO_CACHE_DIR=yes
ENV PIP_DISABLE_PIP_VERSION_CHECK=on
ENV PIP_DEFAULT_TIMEOUT=100

#
# Poetry base config
#
# do not ask any interactive question
ENV POETRY_NO_INTERACTION=1
# never create virtual environment automaticly, only use env prepared by us
ENV POETRY_VIRTUALENVS_CREATE=false

# Install system dependencies for Poetry installation via curl
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    curl build-essential && \
    # Install Poetry using the official installer script
    curl -sSL https://install.python-poetry.org | python && \
    # Remove build dependencies to keep the image slim
    apt-get remove -y curl build-essential && \
    apt-get clean && \
    apt-get -y autoremove

# poetry now sits in root's home dir, update root's PATH to include
ENV PATH="/root/.local/bin:${PATH}"

# Install pipx. pipx installs Python CLI programs in an isolated environment
# in addition it makes the CLI entry points available on $PATH
RUN pip install --upgrade pipx

# Install poetry via pipx
# https://python-poetry.org/docs/#installing-with-pipx
RUN pipx install poetry

# Leave a note behind so we can always quickly determine our original image
RUN echo "${TIMESTAMP}" > /docker-tag
