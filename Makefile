.EXPORT_ALL_VARIABLES:

FLYTE_KIT_VERSION = 1.7.0

FLYTE_PYTHON_VERSION = 3.11

FLYTE_UID = $$(id -u)

TAG = ${FLYTE_KIT_VERSION}-${FLYTE_PYTHON_VERSION}

default: lint build

build:
	docker buildx build \
          --build-arg FLYTE_KIT_VERSION=${FLYTE_KIT_VERSION} \
          --build-arg FLYTE_PYTHON_VERSION=${FLYTE_PYTHON_VERSION} \
          --tag flyte:latest \
          --tag ghcr.io/cbdq-io/flyte:${TAG} \
	  .
	docker images

clean:
	docker compose down -t 0

cleanall:
	docker system prune --all --force
	docker volume prune --all --force

lint:
	docker run --rm -i hadolint/hadolint < Dockerfile

push:
	docker push ghcr.io/cbdq-io/flyte:${TAG}

tag:
	git tag ${TAG}
	git push --tags
	git checkout -b feature/post-${TAG}-release
	git push --set-upstream origin feature/post-${TAG}-release

test:
	docker compose up --wait
