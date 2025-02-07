ARG FLYTE_PYTHON_VERSION
FROM python:${FLYTE_PYTHON_VERSION}

ARG DOCKER_IMAGE
ARG FLYTE_PYTHON_VERSION

ENV FLYTE_INTERNAL_IMAGE="$DOCKER_IMAGE"
ENV HOME=/home/flytekit
ENV PATH=${HOME}/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin

# The version of Flyte Kit to install (e.g. 1.7.0).
ARG FLYTE_KIT_VERSION

LABEL org.opencontainers.image.description="Flyte Kit."
LABEL org.opencontainers.image.source="https://github.com/cbdq-io/docker-flyte"
LABEL org.opencontainers.image.licenses=BSD-3

# The UID for the flyte user.  Defaults to 1000.
ARG FLYTE_UID=1000

USER root
# hadolint ignore=DL3005,DL3008,DL3013
RUN useradd --home-dir /home/flytekit --create-home --uid ${FLYTE_UID} --shell /usr/sbin/nologin flytekit

USER flytekit

WORKDIR /home/flytekit

# hadolint ignore=DL3003,DL3013
RUN pip install --no-cache-dir --quiet --user \
        flytekit==${FLYTE_KIT_VERSION} \
        kubernetes \
        setuptools \
    && pip install --no-cache-dir --quiet --user --upgrade six
