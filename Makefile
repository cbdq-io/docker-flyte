.EXPORT_ALL_VARIABLES:

BUILD_INCREMENT = -1

FLYTE_KIT_VERSION = 1.13.5

FLYTE_PYTHON_VERSION = 3.12

FLYTE_UID = $$(id -u)

DOCKER_TAG = ${FLYTE_KIT_VERSION}-${FLYTE_PYTHON_VERSION}
GIT_TAG = ${FLYTE_KIT_VERSION}-${FLYTE_PYTHON_VERSION}${BUILD_INCREMENT}

default: lint build test clean

changelog:
	gitchangelog > CHANGELOG.md

build:
	@echo "Docker tag is ${DOCKER_TAG}"
	@echo "Git tag is ${GIT_TAG}"
	docker buildx build \
	  --build-arg FLYTE_KIT_VERSION=${FLYTE_KIT_VERSION} \
	  --build-arg FLYTE_PYTHON_VERSION=${FLYTE_PYTHON_VERSION} \
	  --load \
	  --tag flyte:latest \
	  .
	docker images

clean:
	docker compose -f docker-compose.test.yml down -t 0
	docker compose -f examples/wine/docker-compose.yml down -t 0

cleanall:
	docker system prune --all --force
	docker volume prune --all --force

docker-tag:
	@echo ${DOCKER_TAG}

lint:
	docker run --rm -i hadolint/hadolint < Dockerfile

multi-build-latest:
	docker buildx create --use
	docker buildx build --push --platform=linux/amd64,linux/arm64 \
          --build-arg FLYTE_KIT_VERSION=${FLYTE_KIT_VERSION} \
          --build-arg FLYTE_PYTHON_VERSION=${FLYTE_PYTHON_VERSION} \
          --tag ghcr.io/cbdq-io/flyte:latest \
          --annotation 'org.opencontainers.image.description=A Docker Image for Flyte With Spark.' \
	  .

multi-build-tagged:
	@echo "Docker tag is ${DOCKER_TAG}"
	@echo "Git tag is ${GIT_TAG}"
	docker buildx create --use
	docker buildx build --push --platform=linux/amd64,linux/arm64 \
          --build-arg FLYTE_KIT_VERSION=${FLYTE_KIT_VERSION} \
          --build-arg FLYTE_PYTHON_VERSION=${FLYTE_PYTHON_VERSION} \
          --tag ghcr.io/cbdq-io/flyte:latest \
          --tag ghcr.io/cbdq-io/flyte:${DOCKER_TAG} \
          --annotation 'org.opencontainers.image.description=A Docker Image for Flyte With Spark.' \
	  .

release-branch:
	git checkout develop
	git fetch -p origin
	git pull
	git checkout -b release/$(GIT_TAG)

release-commit: changelog
	git add .
	git commit -m 'chg: doc: Changes for release $(GIT_TAG). !minor'

tag:
	@echo ${GIT_TAG}

test:
	docker compose -f docker-compose.test.yml run --build --rm sut

trivy:
	trivy image --severity HIGH,CRITICAL --ignore-unfixed flyte:latest

update-trivy-ignore:
	trivy image --format json --ignore-unfixed --severity HIGH,CRITICAL flyte:latest | jq -r '.Results[1].Vulnerabilities[].VulnerabilityID' | sort -u | tee .trivyignore
