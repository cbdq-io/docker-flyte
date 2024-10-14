# The Python version (e.g. 3.11).
ARG FLYTE_PYTHON_VERSION

FROM python:${FLYTE_PYTHON_VERSION}

ARG DOCKER_IMAGE
ARG FLYTE_PYTHON_VERSION

# The version of Flyte Kit to install (e.g. 1.7.0).
ARG FLYTE_KIT_VERSION

LABEL org.opencontainers.image.description="Flyte Kit and Spark."
LABEL org.opencontainers.image.source="https://github.com/cbdq-io/docker-flyte"
LABEL org.opencontainers.image.licenses=BSD-3

# The UID for the flyte user.  Defaults to 5000.
ARG FLYTE_UID=5000

# hadolint ignore=DL3005,DL3008,DL3013
RUN apt-get clean \
  && apt-get update \
  && apt-get upgrade --yes \
    linux-libc-dev \
  && apt-get install --no-install-recommends --yes \
    software-properties-common \
  && wget --quiet -O /tmp/corretto.key https://apt.corretto.aws/corretto.key \
  && apt-key add /tmp/corretto.key \
  && add-apt-repository --yes 'deb https://apt.corretto.aws stable main' \
  && add-apt-repository --yes 'deb https://apt.corretto.aws stable main' \
  && echo "==============================" \
  && add-apt-repository -L \
  && echo "==============================" \
  && apt-get install --no-install-recommends --yes java-11-amazon-corretto-jdk \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/corretto.key \
  && pip install --no-cache-dir \
    flytekit==${FLYTE_KIT_VERSION} \
    flytekitplugins-spark==${FLYTE_KIT_VERSION} \
    'delta-spark>=3.1.0,<3.2.0' \
    kubernetes \
    setuptools \
  && useradd --home-dir /home/flyte --create-home --uid ${FLYTE_UID} --shell /usr/sbin/nologin flyte

COPY --chown=flyte:flyte --chmod=0555 entrypoint.sh /usr/local/bin/entrypoint.sh
USER flyte

ENV FLYTE_INTERNAL_IMAGE="$DOCKER_IMAGE"
ENV HOME=/home/flyte
ENV JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto
ENV SPARK_HOME=/usr/local/lib/python${FLYTE_PYTHON_VERSION}/site-packages/pyspark
ENV PATH=${HOME}/.local/bin:${JAVA_HOME}/bin:${SPARK_HOME}/bin:/usr/local/bin:/usr/bin:/bin

WORKDIR /home/flyte
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
