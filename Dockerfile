ARG FLYTE_PYTHON_VERSION
FROM python:${FLYTE_PYTHON_VERSION}-slim-bookworm AS builder

ENV PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin
ENV ENVD_VERSION=0.4.3

COPY install-go.sh /usr/local/bin/install-go.sh

# hadolint ignore=DL3003,DL3008,DL3013
RUN apt-get update \
  && apt-get --no-install-recommends --yes install \
    git \
    make \
    wget \
  && /usr/local/bin/install-go.sh \
  && git clone --depth 1 --branch "v${ENVD_VERSION}" https://github.com/tensorchord/envd.git /tmp/envd \
  && cd /tmp/envd \
  && pip install --no-cache-dir setuptools \
  && make pypi-build

ARG FLYTE_PYTHON_VERSION
FROM python:${FLYTE_PYTHON_VERSION}-slim-bookworm

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
RUN useradd --home-dir /home/flytekit --create-home --uid ${FLYTE_UID} --shell /usr/sbin/nologin flytekit \
  && chown -R flytekit /root /home

USER flytekit

WORKDIR /root
COPY --from=builder /tmp/envd/dist/envd-0.4.3-py2.py3-none-linux_aarch64.whl /tmp/

# hadolint ignore=DL3013
RUN pip install --no-cache-dir --quiet --user \
        flytekit==${FLYTE_KIT_VERSION} \
        kubernetes \
        setuptools \
        /tmp/envd-0.4.3-py2.py3-none-linux_aarch64.whl \
    && pip install --no-cache-dir --quiet --user --upgrade six
