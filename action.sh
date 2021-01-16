#!/bin/bash

set -e
set -o pipefail




if [[ -z "${HUGO_VERSION}" ]]; then
    HUGO_VERSION=0.80.0
    echo "No HUGO_VERSION was set, so defaulting to ${HUGO_VERSION}"
fi

if [[ "${HUGO_EXTENDED}" = "true" ]]; then
  EXTENDED_INFO=" (extended)"
  EXTENDED_URL="extended_"
else
  EXTENDED_INFO=""
  EXTENDED_URL=""
fi

echo "Downloading Hugo: ${HUGO_VERSION}${EXTENDED_INFO}"
URL=https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${EXTENDED_URL}${HUGO_VERSION}_Linux-64bit.deb
echo "Using '${URL}' to download Hugo"
curl -sSL "${URL}" > /tmp/hugo.deb && dpkg --force architecture -i /tmp/hugo.deb

echo "Building the Hugo site with: 'hugo ${HUGO_ARGS}'"
hugo "${HUGO_ARGS}"

echo "Complete"
