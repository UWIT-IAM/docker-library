# e.g., "3.10"
ARG PYTHON_VERSION
# e.g., 2024.01.17.15.09.31
ARG TIMESTAMP

FROM python:${PYTHON_VERSION}-slim as python-base-BASE

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
    POETRY_VIRTUALENVS_CREATE=false

# Install pipx. pipx installs Python CLI programs in an isolated environment
# in addition it makes the CLI entry points available on $PATH
RUN pip install --upgrade pipx && \
    pipx ensurepath

# Install poetry via pipx
# https://python-poetry.org/docs/#installing-with-pipx
#
# NOTE: this will emit "'/root/.local/bin' is not on your PATH environment variable."
#       This is true at install time but at runtime a new shell will be started that
#       has that fixed per `pipx ensurepath` above
RUN pipx install poetry

# Leave a note behind so we can always quickly determine our original image
RUN echo "${TIMESTAMP}" > /docker-tag
