# Dockerfile for Hugo (HUGO=hugo) / Hugo Extended (HUGO=hugo_extended)
# HUGO_VERSION / HUGO_SHA / HUGO_EXTENDED_SHA is automatically updated
# by update.py when new release is available on the upstream.
# Utilize multi-stage builds to make images optimized in size.

# First stage - download prebuilt hugo binary from the GitHub release.
# Use golang image to run https://github.com/yaegashi/muslstack
# on hugo executable to extend its default thread stack size to 8MB
# to work around segmentation fault issues.
FROM golang:1.15-alpine
RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	ca-certificates  \
	curl \
	git && \
	rm -rf /var/lib/apt/lists/*

COPY action.sh /usr/bin/action.sh

ENTRYPOINT ["action.sh"]
