ARG from_base_tag=latest
FROM ghcr.io/uwit-iam/poetry:${from_base_tag} as uwit-iam-xmlsec-base
WORKDIR $POETRY_HOME
COPY ./* ./
RUN ./bootstrap-xmlsec-env.sh
