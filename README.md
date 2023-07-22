# A Docker Image for Flyte

A base image that contains
[Flyte Kit](https://docs.flyte.org/en/latest/index.html).

## Examples

### Machine Learning

Using the example provided by Flyte for the wine dataset of scikit-learn,
run the following example:

```shell
docker compose -f examples/wine/docker-compose.yml up --build
```

The output should have something similar to this:

```
wine-example-1  | LogisticRegression(C=0.1, max_iter=3000)
```
### Spark

Again, using an example provided by Flyte
(see <https://docs.flyte.org/projects/cookbook/en/latest/auto_examples/k8s_spark_plugin/pyspark_pi.html>).

```shell
docker compose -f examples/spark/docker-compose.yml up --build
```

The output should be something similar to this:

```
spark-example-spark-1  | Starting Spark with Partitions: 50
spark-example-spark-1  | Pi val is :3.1425424
spark-example-spark-1  | My printed value: 3.1425424 @ 2023-07-22 08:18:10.128835+00:00
spark-example-spark-1  | 3.1425424
spark-example-spark-1 exited with code 0
```

## Spark on Kubernetes

```shell
helm repo add flyteorg https://flyteorg.github.io/flyte
```

Install the Spark Operator Helm chart:

```shell
helm repo add spark-operator \
  https://googlecloudplatform.github.io/spark-on-k8s-operator
```

Install the Spark Operator:

```shell
helm install spark-operator spark-operator/spark-operator \
  --namespace spark-operator \
  --create-namespace \
  --set image.tag=v1beta2-1.3.8-3.1.1
```
