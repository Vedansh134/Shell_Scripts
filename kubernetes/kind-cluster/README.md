# KIND Cluster Setup Guide

## 1. Installing KIND and kubectl
Install KIND and kubectl using the provided [kind & kubectl install script](https://github.com/vedansh134/kubestarter/blob/main/kind-cluster/kind_install.sh):

## 2. Setting Up the KIND Cluster
Create a kind-config.yaml file:

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    image: kindest/node:v1.33.1
  - role: worker
    image: kindest/node:v1.33.1
  - role: worker
    image: kindest/node:v1.33.1
```

## 3. Create the KIND cluster using the configuration file:

```bash

kind create cluster --config kind-config.yaml --name=app-cluster
```

verify the cluster is running:

```bash

kubectl cluster-info
kubetl get nodes
```

## 4. Deleting the KIND Cluster

To delete the KIND cluster, run:

```bash

kind delete cluster --name=app-cluster
```

## 5. Notes

Multiple Clusters: KIND supports multiple clusters. Use unique --name for each cluster.
Custom Node Images: Specify Kubernetes versions by updating the image in the configuration file.
Ephemeral Clusters: KIND clusters are temporary and will be lost if Docker is restarted.