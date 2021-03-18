FROM gcr.io/uwit-mci-iam/poetry:latest as uwit-iam-xmlsec-base
COPY images/uw-saml-poetry/* $POETRY_HOME/
ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"
RUN echo $PATH && $POETRY_HOME/bootstrap-xmlsec-env.sh
