#!/bin/sh
#############################################################################
# Entry point for the flyte container.
#############################################################################
set -e

if [ -n "${_PIP_ADDITIONAL_REQUIREMENTS}" ]; then
  pip freeze > /tmp/constraints.txt
  echo "${_PIP_ADDITIONAL_REQUIREMENTS}" | tr ',' '\n' | tee /tmp/requirements.txt
  pip install --no-cache-dir --constraint /tmp/constraints.txt --requirement /tmp/requirements.txt
  pip check
fi

$*
