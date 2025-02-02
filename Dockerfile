# If the version of PySpark installed as a dependency of
# flytekitplugins-spark chages, the we need to move to
# that version of Spark.
FROM spark:3.5.4

ARG DOCKER_IMAGE
ARG FLYTE_PYTHON_VERSION

ENV GO_VERSION=1.22

# The version of Flyte Kit to install (e.g. 1.7.0).
ARG FLYTE_KIT_VERSION

LABEL org.opencontainers.image.description="Flyte Kit and Spark."
LABEL org.opencontainers.image.source="https://github.com/cbdq-io/docker-flyte"
LABEL org.opencontainers.image.licenses=BSD-3

# The UID for the flyte user.  Defaults to 1000.
ARG FLYTE_UID=1000

USER root
# hadolint ignore=DL3005,DL3008
RUN apt-get clean \
  && apt-get update \
  && apt-get install --no-install-recommends --yes software-properties-common\
  && add-apt-repository ppa:deadsnakes/ppa \
  && apt-get update \
  && apt-get install --no-install-recommends --yes \
    git \
    golang-${GO_VERSION}-go \
    python${FLYTE_PYTHON_VERSION} \
    python${FLYTE_PYTHON_VERSION}-dev \
    python3-cairo-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && useradd --home-dir /home/flytekit --create-home --uid ${FLYTE_UID} --shell /usr/sbin/nologin flytekit \
  && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1 \
  && update-alternatives --config python3 \
  && sh -c "curl -sS https://bootstrap.pypa.io/get-pip.py | python3.12"

USER flytekit

ENV ENVD_VERSION=0.4.3
ENV FLYTE_INTERNAL_IMAGE="$DOCKER_IMAGE"
ENV HOME=/home/flytekit
ENV JAVA_HOME=/opt/java/openjdk
ENV SPARK_HOME=/opt/spark
ENV PATH=${HOME}/.local/bin:${JAVA_HOME}/bin:${SPARK_HOME}/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/go-1.22/bin

WORKDIR /home/flytekit

# hadolint ignore=DL3003,DL3013
RUN pip install -U --no-cache-dir --quiet --user setuptools wheel \
    && git clone --depth 1 --branch "v${ENVD_VERSION}" https://github.com/tensorchord/envd.git /tmp/envd \
    && cd /tmp/envd \
    && pip install --no-cache-dir --quiet --user . \
    && pip install --no-cache-dir --quiet --user \
        flytekit==${FLYTE_KIT_VERSION} \
        flytekitplugins-envd==${FLYTE_KIT_VERSION} \
        flytekitplugins-spark==${FLYTE_KIT_VERSION} \
        'delta-spark>=3.1.0,<3.2.0' \
        kubernetes \
    && python3 -m pip install --no-cache-dir --quiet --user --upgrade six \
    && rm -rf /home/flytekit/.local/lib/python3.12/site-packages/google/auth/crypt/__pycache__ /tmp/envd
