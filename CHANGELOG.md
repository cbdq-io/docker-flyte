# Changelog


## 1.14.6-3.12-1

### Fix

* We are dropping Spark and Deltalake. [Ben Dalling]

* Trivy should concentrate on vulnerabilities. [Ben Dalling]

* Swap venv for envd. [Ben Dalling]

* Use a Spark 3.5.4 base image. [Ben Dalling]

### Other

* Fix(ci): Update .trivyignore. [Ben Dalling]

* Fix(chore): Remove __pycache__ with false positive for a security alert. [Ben Dalling]

* Fix(ci): Correct execution of Delta test. [Ben Dalling]


## 1.14.6-3.12-1 (2025-01-25)

### Fix

* Ensure useradd is on the path. [Ben Dalling]

* Bump Flyte Kit from 1.14.4 to 1.14.6. [Ben Dalling]


## 1.14.4-3.12-1 (2025-01-18)

### Fix

* Bump Flyte Kit from 1.14.3 to 1.14.4. [Ben Dalling]


## 1.14.3-3.12-1 (2025-01-04)

### Changes

* Bump Flytekit version from 1.14.0 to 1.14.3. [Ben Dalling]


## 1.14.0-3.12-1 (2024-12-09)

### Changes

* Bump Flyte Kit 1.13.14 to 1.14.0. [Ben Dalling]


## 1.13.14-3.12-1 (2024-11-26)

### Changes

* Add CVE-2024-47535 to allowed vulnerabilities. [Ben Dalling]

* Bump Flyte Kit from 1.13.13 to 1.13.14. [Ben Dalling]

### Other

* Build(deps): bump aquasecurity/trivy-action from 0.28.0 to 0.29.0. [dependabot[bot]]

  Bumps [aquasecurity/trivy-action](https://github.com/aquasecurity/trivy-action) from 0.28.0 to 0.29.0.
  - [Release notes](https://github.com/aquasecurity/trivy-action/releases)
  - [Commits](https://github.com/aquasecurity/trivy-action/compare/0.28.0...0.29.0)

  ---
  updated-dependencies:
  - dependency-name: aquasecurity/trivy-action
    dependency-type: direct:production
    update-type: version-update:semver-minor
  ...


## 1.13.13-3.12-1 (2024-11-12)

### Changes

* Bump Flyte Kit version from 1.13.12 to 1.13.13. [Ben Dalling]


## 1.13.12-3.12-1 (2024-11-01)

### Changes

* Bump Flyte Kit version from 1.13.8 to 1.13.12. [Ben Dalling]

### Fix

* Add CVE-2023-52428 to allowed vulnerabilities. [Ben Dalling]


## 1.13.8-3.12-2 (2024-10-16)

### New

* Add a description to the image. [Ben Dalling]

### Changes

* Release to fix broken executables. [Ben Dalling]

* Bump Flyte Kit version from 1.13.4 to 1.13.5. [Ben Dalling]

### Fix

* Set the FLYTE_INTERNAL_IMAGE environment variable in the container.  Also ensure that the Flyte Kit commands execute correctly. [Ben Dalling]

* Add CVE-2024-7254 to .trivyignore. [Ben Dalling]

* CVE-2024-26308 no longer found in the image. [Ben Dalling]

* CVE-2024-5171. [Ben Dalling]

### Other

* Build(deps): bump docker/setup-buildx-action from 2 to 3. [dependabot[bot]]

  Bumps [docker/setup-buildx-action](https://github.com/docker/setup-buildx-action) from 2 to 3.
  - [Release notes](https://github.com/docker/setup-buildx-action/releases)
  - [Commits](https://github.com/docker/setup-buildx-action/compare/v2...v3)

  ---
  updated-dependencies:
  - dependency-name: docker/setup-buildx-action
    dependency-type: direct:production
    update-type: version-update:semver-major
  ...

* Build(deps): bump docker/build-push-action from 5 to 6. [dependabot[bot]]

  Bumps [docker/build-push-action](https://github.com/docker/build-push-action) from 5 to 6.
  - [Release notes](https://github.com/docker/build-push-action/releases)
  - [Commits](https://github.com/docker/build-push-action/compare/v5...v6)

  ---
  updated-dependencies:
  - dependency-name: docker/build-push-action
    dependency-type: direct:production
    update-type: version-update:semver-major
  ...


## 1.13.8-3.12-1 (2024-10-08)

### New

* Add CVE-2024-47554 to the allowed vulnerabilities. [Ben Dalling]

### Changes

* Update Flyte Kit version from 1.13.7 to 1.13.8. [Ben Dalling]

* Update Flyte Kit version from 1.13.5 to 1.13.7. [Ben Dalling]


## 1.13.5-3.12-3 (2024-10-01)

### Fix

* Add CVE-2024-7254 to .trivyignore. [Ben Dalling]


## 1.13.5-3.12-2 (2024-09-17)

### Fix

* CVE-2024-26308 not longer found in image. [Ben Dalling]

* Rebuild image to fix CVE-2023-25652, CVE-2023-29007, CVE-2024-32002, CVE-2024-32004 and CVE-2024-32465. [Ben Dalling]


## 1.13.5-3.12-1 (2024-09-02)

### Changes

* Bump Flyte Kit version from 1.13.4 to 1.13.5. [Ben Dalling]


## 1.13.4-3.12-1 (2024-08-16)

### Changes

* Bump Flyte Kit version from 1.13.3 to 1.13.4. [Ben Dalling]


## 1.13.3-3.12-1 (2024-08-13)

### Changes

* Bump Flyte Kit version from 1.13.2 to 1.13.3. [Ben Dalling]

### Fix

* CVE-2023-43642 & CVE-2024-36114 no longer detected. [Ben Dalling]


## 1.13.2-3.12-1 (2024-08-07)

### Changes

* Bump Flyte Kit version from 1.13.1 to 1.13.2. [Ben Dalling]


## 1.13.1-3.12-1 (2024-07-30)

### Fix

* Bump Flyte Kit version from 1.13.0 to 1.13.1. [Ben Dalling]

* Add CVE-2024-25638 to the allowed list of vulnerabilities. [Ben Dalling]


## 1.13.0-3.12-1 (2024-07-09)

### Changes

* Blump the Flyte Kit version from 1.12.3 to 1.13.0. [Ben Dalling]


## 1.12.3-3.12-1 (2024-06-18)

### Changes

* Bump Flyte Kit version from 1.12.2 to 1.12.3. [Ben Dalling]


## 1.12.2-3.12-1 (2024-06-11)

### New

* Add CVE-2024-36114 to the allowed vulnerabilities list. [Ben Dalling]

### Changes

* Blump Flyte Kit version from 1.12.0 to 1.12.2. [Ben Dalling]


## 1.12.0-3.12-1 (2024-05-14)

### New

* Add hook for _PIP_ADDITIONAL_REQUIREMENTS on entry to the container. [Ben Dalling]

### Changes

* Bump Flyte Kit version from 1.11.0 to 1.12.0. [Ben Dalling]

### Fix

* Add bin directories to the PATH in the container. [Ben Dalling]


## 1.11.0-3.12-1 (2024-03-19)

### Changes

* Bump Flyte Kit version from 1.10.7 to 1.11.0. [Ben Dalling]


## 1.10.7-3.12-2 (2024-03-10)

### New

* Add Delta Lake to the image. [Ben Dalling]

### Fix

* Correct path for Python 3.12. [Ben Dalling]


## 1.10.7-3.12-1 (2024-02-28)

### Changes

* Bump Flyte Kit version from 1.10.3 to 1.10.7. [Ben Dalling]


## 1.10.3-3.12-1 (2024-02-01)

### Changes

* Bump Python from 3.11 to 3.12. [Ben Dalling]

* Bump Flyte Kit version from 1.10.2 to 1.10.3. [Ben Dalling]


## 1.10.2-3.11-1 (2023-12-13)

### Changes

* Bump Flytekit version from 1.9.1 to 1.10.2. [Ben Dalling]

### Fix

* Remove CVE-2022-1471 and add CVE-2023-39410 to the allowed vulnerabilities. [Ben Dalling]

* Add CVE-2023-43642 to the allowed vulnerabilities. [Ben Dalling]


## 1.9.1-3.11-1 (2023-09-05)

### New

* Add CVE-2022-46751 to the allowed list. [Ben Dalling]

* Add labels to the Docker image. [Ben Dalling]

### Changes

* Bump Flyte Kit from 1.9.0 to 1.9.1. [Ben Dalling]

### Fix

* CVE-2021-22570 is no longer detected. [Ben Dalling]


## 1.9.0-3.11-1 (2023-08-12)

### Changes

* Bump Flyte Kit version from 1.8.3 to 1.9.0. [Ben Dalling]

* Specify that the image also has Spark. [Ben Dalling]

* Bump FlyteKit from 1.8.1 to 1.8.3. [Ben Dalling]


## 1.8.1-3.11-1 (2023-07-22)

### New

* Add Spark examples. [Ben Dalling]

* Add description to the Docker image. [Ben Dalling]

* Add Spark to the image. [Ben Dalling]

### Changes

* Bump Flyte Kit version from 1.8.0 to 1.8.1. [Ben Dalling]


## 1.8.0-3.11-1 (2023-07-18)

### Changes

* Bump FlyteKit version from 1.7.0 to 1.8.0. [Ben Dalling]


## 1.7.0-3.11-2 (2023-07-10)

### New

* Add scikit-learn wine example. [Ben Dalling]

* Push a latest Docker tag on push to develop. [Ben Dalling]

### Fix

* Set flyte shell to be nologin. [Ben Dalling]


## 1.7.0-3.11 (2023-07-09)

### New

* Flyte Kit 1.7.0 running on Python 3.11. [Ben Dalling]

### Other

* Create LICENSE. [Ben Dalling]

  new: doc: Add BSD-3 licence.

* Initial commit. [Ben Dalling]


