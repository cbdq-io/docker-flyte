# The Python version (e.g. 3.11).
ARG FLYTE_PYTHON_VERSION

FROM python:${FLYTE_PYTHON_VERSION}

# The version of Flyte Kit to install (e.g. 1.7.0).
ARG FLYTE_KIT_VERSION

# The UID for the flyte user.  Defaults to 5000.
ARG FLYTE_UID=5000

RUN apt-get clean \
  && apt-get update \
  && apt-get upgrade --yes \
    linux-libc-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && pip install --no-cache-dir flytekit==${FLYTE_KIT_VERSION} \
  && useradd --home-dir /home/flyte --create-home --uid ${FLYTE_UID} flyte

USER flyte

WORKDIR /home/flyte
