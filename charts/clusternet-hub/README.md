# How to install clusternet-hub

`clusternet-hub` is responsible for

- approving cluster registration requests and creating dedicated
  resources, such as namespaces, serviceaccounts and RBAC rules, for
  each child cluster;
- serving as an **aggregated apiserver (AA)**, which is used to serve as
  a websocket server that maintain multiple active websocket connections
  from child clusters;
- providing Kubernstes-styled API to redirect/proxy/upgrade requests to
  each child cluster;
- coordinating and deploying applications to multiple clusters from a
  single set of APIs;

> :pushpin: :pushpin: Note:
>
> Since `clusternet-hub` is running as an AA, please make sure that
> parent apiserver could visit the `clusternet-hub` service.

## Prerequisites

- Kubernetes 1.18+
- Helm 3.1.0

## TL;DR

```bash
helm repo add clusternet https://clusternet.github.io/charts
helm install clusternet-hub -n clusternet-system --create-namespace clusternet/clusternet-hub
```

### Create Auth Token

- If bootstrapping authentication is supported, i.e.
  `--enable-bootstrap-token-auth=true` is explicitly set in the
  kube-apiserver running in parent cluster.

  ```bash
  kubectl apply -f https://raw.githubusercontent.com/clusternet/clusternet/main/manifests/samples/cluster_bootstrap_token.yaml
  ```

- If bootstrapping authentication is **not supported** by the
  kube-apiserver in parent cluster (like k3s) , i.e.
  `--enable-bootstrap-token-auth=false` (which defaults to be false),
  please use serviceaccount token instead.

  ```bash
  # this will create a serviceaccount token
  kubectl apply -f https://raw.githubusercontent.com/clusternet/clusternet/main/manifests/samples/cluster_serviceaccount_token.yaml
  ```

### Get ServiceAccount Token from parent cluster

```bash
kubectl get secret -n clusternet-system -o=jsonpath='{.items[?(@.metadata.annotations.kubernetes\.io/service-account\.name=="cluster-bootstrap-use")].data.token}' | base64 -i --decode; echo
# HERE WILL OUTPUTS A LONG STRING. PLEASE REMEMBER THIS.
```

## Step-by-step Installation & Uninstallation

### Installing the Chart

> Note: The images are synced to
> [dockerhub](https://hub.docker.com/u/clusternet) as well, you could
> set `image.registry` to empty or `docker.io` if needed.

To install the chart with the release name `clusternet-hub`:

```bash
helm repo add clusternet https://clusternet.github.io/charts
helm install clusternet-hub -n clusternet-system --create-namespace clusternet/clusternet-hub
kubectl apply -f https://raw.githubusercontent.com/clusternet/clusternet/main/manifests/samples/cluster_bootstrap_token.yaml
```

These commands deploy `clusternet-hub` on the Kubernetes cluster in the
default configuration. The [Parameters](#parameters) section lists the
parameters that can be configured during installation.

> **Tip**: List all releases using `helm list -A`

### Uninstalling the Chart

To uninstall/delete the `clusternet-hub` deployment:

```bash
helm delete clusternet-hub -n clusternet-system
```

The command removes all the Kubernetes components associated with the
chart and deletes the release.

### Parameters

#### Common parameters

| Name                | Description                                        | Value |
|:--------------------|:---------------------------------------------------|:------|
| `kubeVersion`       | Override Kubernetes version                        | `""`  |
| `nameOverride`      | String to partially override common.names.fullname | `""`  |
| `fullnameOverride`  | String to fully override common.names.fullname     | `""`  |
| `commonLabels`      | Labels to add to all deployed objects              | `{}`  |
| `commonAnnotations` | Annotations to add to all deployed objects         | `{}`  |

#### Exposure parameters

| Name                        | Description                                                                               | Value                                  |
|:----------------------------|:------------------------------------------------------------------------------------------|:---------------------------------------|
| `replicaCount`              | Specify number of clusternet-hub replicas                                                 | `3`                                    |
| `serviceAccount.name`       | The name of the ServiceAccount to create                                                  | `"clusternet-hub"`                     |
| `securePort`                | Port where clusternet-hub will be running                                                 | `443`                                  |
| `peerPort`                  | Port where clusternet-hub peer will be advertised                                         | `8123`                                 |
| `image.registry`            | clusternet-hub image registry                                                             | `ghcr.io`                              |
| `image.repository`          | clusternet-hub image repository                                                           | `clusternet/clusternet-hub`            |
| `image.tag`                 | clusternet-hub image tag (immutable tags are recommended)                                 | `v0.18.0`                              |
| `image.pullPolicy`          | clusternet-hub image pull policy                                                          | `IfNotPresent`                         |
| `image.pullSecrets`         | Specify docker-registry secret names as an array                                          | `[]`                                   |
| `reservedNamespace`         | Reserved namespace used for creating Manifest by clusternet-hub                           | `clusternet-reserved`                  |
| `anonymousAuthSupported`    | Whether the anonymous access is allowed by the 'core' kubernetes server                   | `true`                                 |
| `leaderElect`               | Enable or disable leader elect                                                            | `true`                                 |
| `featureGates`              | Enable or disable feature gates                                                           | `SocketConnection=true,ShadowAPI=true` |
| `kubeAPI.burst`             | Kubernetes API client Burst limit to use while talking with 'core' kubernetes apiserver   | `100`                                  |
| `kubeAPI.qps`               | Kubernetes API client QPS limit to use while talking with the 'core' kubernetes apiserver | `50.0`                                 |
| `extraArgs`                 | Additional command line arguments to pass to clusternet-hub                               | `{}`                                   |
| `resources.limits`          | The resources limits for the container                                                    | `{}`                                   |
| `resources.requests`        | The requested resources for the container                                                 | `{}`                                   |
| `nodeSelector`              | Node labels for pod assignment                                                            | `{}`                                   |
| `priorityClassName`         | Set Priority Class Name to allow priority control over other pods                         | `""`                                   |
| `hostNetwork`               | Specify whether to use the host's networking stack                                        | `false`                                |
| `tolerations`               | Tolerations for pod assignment                                                            | `[]`                                   |
| `podAffinityPreset`         | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`       | `""`                                   |
| `podAntiAffinityPreset`     | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`  | `soft`                                 |
| `nodeAffinityPreset.type`   | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard` | `""`                                   |
| `nodeAffinityPreset.key`    | Node label key to match. Ignored if `affinity` is set.                                    | `""`                                   |
| `nodeAffinityPreset.values` | Node label values to match. Ignored if `affinity` is set.                                 | `[]`                                   |
| `affinity`                  | Affinity for pod assignment                                                               | `{}`                                   |

