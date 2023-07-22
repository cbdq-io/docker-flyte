# Contributing

## Cutting a Release

Create a release branch:

```shell
make release-branch
```

Update the change log:

```shell
make changelog
```

Review the changes in `CHANGELOG.md`, if all looks OK, finish the release
with:

```shell
release-commit
```

Push changes to Git.  If CI passes, raise a PR from the release branch to
`main`.  When that branch is merged, the Continual Deployment will create
the Git tag and publish the Docker image.  Subsequently a branch will
be created called `feature/post-${GIT_TAG}-release`.  This branch should
be merged back onto `develop` to complete the release process.
