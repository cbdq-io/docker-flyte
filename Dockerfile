# The Python version (e.g. 3.11).
ARG FLYTE_PYTHON_VERSION

FROM python:${FLYTE_PYTHON_VERSION}

# The version of Flyte Kit to install (e.g. 1.7.0).
ARG FLYTE_KIT_VERSION

LABEL org.opencontainers.image.description Flyte Kit and Spark.

# The UID for the flyte user.  Defaults to 5000.
ARG FLYTE_UID=5000

# hadolint ignore=DL3005,DL3008
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
  && useradd --home-dir /home/flyte --create-home --uid ${FLYTE_UID} --shell /usr/sbin/nologin flyte

USER flyte

ENV JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto
ENV SPARK_HOME=/usr/local/lib/python3.11/site-packages/pyspark

WORKDIR /home/flyte
