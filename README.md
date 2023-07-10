# A Docker Image for Flyte

A base image that contains
[Flyte Kit](https://docs.flyte.org/en/latest/index.html).

## Examples

Using the example provided by Flyte for the wine dataset of scikit-learn,
run the following example:

```shell
docker compose -f examples/wine/docker-compose.yml up --build
```

The output should have something similar to this:

```
wine-example-1  | LogisticRegression(C=0.1, max_iter=3000)
```
