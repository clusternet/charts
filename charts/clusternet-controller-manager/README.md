# How to install clusternet-controller-manager

`clusternet-controller-manager` is responsible for running all
controllers


## Prerequisites

- Kubernetes 1.18+
- Helm 3.1.0


## Step-by-step Installation & Uninstallation

### Installing the Chart

> Note: The images are synced to
> [dockerhub](https://hub.docker.com/u/clusternet) as well, you could
> set `image.registry` to empty or `docker.io` if needed.

To install the chart with the release name
`clusternet-controller-manager`:

```bash
helm repo add clusternet https://clusternet.github.io/charts
helm install clusternet-controller-manager -n clusternet-system --create-namespace clusternet/clusternet-controller-manager
```

These commands deploy `clusternet-controller-manager` on the Kubernetes
cluster in the default configuration. The [Parameters](#parameters)
section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list -A`

### Uninstalling the Chart

To uninstall/delete the `clusternet-controller-manager` deployment:

```bash
helm delete clusternet-controller-manager -n clusternet-system
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

| Name                        | Description                                                                               | Value                                                                                               |
|:----------------------------|:------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------|
| `replicaCount`              | Specify number of clusternet-controller-manager replicas                                  | `3`                                                                                                 |
| `serviceAccount.name`       | The name of the ServiceAccount to create                                                  | `"clusternet-controller-manager"`                                                                   |
| `securePort`                | Port where clusternet-controller-manager will be running                                  | `443`                                                                                               |
| `controller`                | Controller a list of controllers to enable                                                | `"*"`                                                                                               |
| `image.registry`            | clusternet-controller-manager image registry                                              | `ghcr.io`                                                                                           |
| `image.repository`          | clusternet-controller-manager image repository                                            | `clusternet/clusternet-controller-manager`                                                          |
| `image.tag`                 | clusternet-controller-manager image tag (immutable tags are recommended)                  | `v0.18.0`                                                                                           |
| `image.pullPolicy`          | clusternet-controller-manager image pull policy                                           | `IfNotPresent`                                                                                      |
| `image.pullSecrets`         | Specify docker-registry secret names as an array                                          | `[]`                                                                                                |
| `reservedNamespace`         | Reserved namespace used for creating Manifest by clusternet-controller-manager            | `clusternet-reserved`                                                                               |
| `anonymousAuthSupported`    | Whether the anonymous access is allowed by the 'core' kubernetes server                   | `true`                                                                                              |
| `leaderElect`               | Enable or disable leader elect                                                            | `true`                                                                                              |
| `featureGates`              | Enable or disable feature gates                                                           | `SocketConnection=true,Deployer=true,FeedInUseProtection=true,FeedInventory=true,ClusterInit=false` |
| `kubeAPI.burst`             | Kubernetes API client Burst limit to use while talking with 'core' kubernetes apiserver   | `100`                                                                                               |
| `kubeAPI.qps`               | Kubernetes API client QPS limit to use while talking with the 'core' kubernetes apiserver | `50.0`                                                                                              |
| `extraArgs`                 | Additional command line arguments to pass to clusternet-controller-manager                | `{}`                                                                                                |
| `resources.limits`          | The resources limits for the container                                                    | `{}`                                                                                                |
| `resources.requests`        | The requested resources for the container                                                 | `{}`                                                                                                |
| `nodeSelector`              | Node labels for pod assignment                                                            | `{}`                                                                                                |
| `priorityClassName`         | Set Priority Class Name to allow priority control over other pods                         | `""`                                                                                                |
| `hostNetwork`               | Specify whether to use the host's networking stack                                        | `false`                                                                                             |
| `tolerations`               | Tolerations for pod assignment                                                            | `[]`                                                                                                |
| `podAffinityPreset`         | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`       | `""`                                                                                                |
| `podAntiAffinityPreset`     | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`  | `soft`                                                                                              |
| `nodeAffinityPreset.type`   | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard` | `""`                                                                                                |
| `nodeAffinityPreset.key`    | Node label key to match. Ignored if `affinity` is set.                                    | `""`                                                                                                |
| `nodeAffinityPreset.values` | Node label values to match. Ignored if `affinity` is set.                                 | `[]`                                                                                                |
| `affinity`                  | Affinity for pod assignment                                                               | `{}`                                                                                                |

