FROM ghcr.io/uwit-iam/poetry:latest as uwit-iam-xmlsec-base
WORKDIR $POETRY_HOME
COPY images/uw-saml-poetry/* ./
ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"
RUN ./bootstrap-xmlsec-env.sh
