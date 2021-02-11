#Datadog K8s Agent Installation
Based on [Datadog k8s agent installation](https://docs.datadoghq.com/agent/kubernetes/?tab=daemonset).
The approach is to not use Helm as much as possible, on this case there is a simple alternative using DaemonSet.
## Agent permissions configuration
[permissions.yaml](permissions.yaml) is a merge of 3 files:
- [clusterrole.yam](https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrole.yaml)
- [serviceaccount.yaml](https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/serviceaccount.yaml)
- [clusterrolebinding.yaml]("https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrolebinding.yaml")

with one change of taking the default namespace out.

*comment: clusterrole is cross-namespace element and not required setting the namespace like the two others.*

```shell
kubectl apply -f permissions.yaml -n [namespace]
```

## Agent deployment
Based on Datadog official guideline using [datadog-agent-apm.yaml](https://docs.datadoghq.com/resources/yaml/datadog-agent-apm.yaml).
Added "DD_ENV" environment variable

```shell
kubectl apply -f datadog-agent.yaml -n [namespace]
```kubectl apply -f datadog-agent.yaml -n [namespace]