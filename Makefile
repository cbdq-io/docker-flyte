.EXPORT_ALL_VARIABLES:

BUILD_INCREMENT = -1

FLYTE_KIT_VERSION = 1.14.6

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
          --build-arg DOCKER_IMAGE="flyte:latest" \
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

flyte-kit-version:
	@echo ${FLYTE_KIT_VERSION}

hotfix-branch:
	git checkout main
	git fetch -p origin
	git pull
	git checkout -b hotfix/$(GIT_TAG)

lint:
	docker run --rm -i hadolint/hadolint < Dockerfile

python-version:
	@echo ${FLYTE_PYTHON_VERSION}

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
	trivy --scanners vuln image flyte:latest

update-trivy-ignore:
	trivy image --scanners vuln --format json --ignore-unfixed --severity HIGH,CRITICAL flyte:latest | jq -r '.Results[1].Vulnerabilities[].VulnerabilityID' | sort -u | tee .trivyignore
