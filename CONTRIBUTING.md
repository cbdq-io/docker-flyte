# Contributing

## Cutting a Release

Create a release branch:

```shell
make release-branch
```

Push changes to Git.  If CI passes, raise a PR from the release branch to
`main`.  When that branch is merged, the Continual Deployment will create
the Git tag and publish the Docker image.
