# This is the base image for our python+poetry environment and is publicly
# available at uwitiam/poetry:latest.
# The base template for this taken from
# https://github.com/python-poetry/poetry/issues/1879
#
# When using this, you may find it helpful to use the following environment
# variables in dependent builds:
#
# PYSETUP_PATH -- All python requirements will be installed there.
# VENV_PATH -- The virtual environment that poetry will use.
# POETRY_HOME -- Where poetry will be installed.
#
# All three will be added to the environment's PATH.

FROM python:3.8-slim as poetry-base
ENV PYTHONUNBUFFERED=1 \
    # prevents python creating .pyc files
    PYTHONDONTWRITEBYTECODE=1 \
    \
    # pip
    PIP_NO_CACHE_DIR=yes \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    \
    # poetry
    # https://python-poetry.org/docs/configuration/#using-environment-variables
    # make poetry install to this location
    POETRY_HOME="/opt/poetry" \
    # make poetry create the virtual environment in the project's root
    # it gets named `.venv`
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    # do not ask any interactive question
    POETRY_NO_INTERACTION=1 \
    # this is where our requirements + virtual environment will live
    PYSETUP_PATH="/opt/pysetup" \
    VENV_PATH="/opt/pysetup/.venv"  \
    # prepend poetry and venv to path
    PATH="${POETRY_HOME}/bin:${VENV_PATH}/bin:${PATH}"

WORKDIR $POETRY_HOME
COPY ./images/poetry/* $POETRY_HOME/
RUN ${POETRY_HOME}/bootstrap-poetry-env.sh
