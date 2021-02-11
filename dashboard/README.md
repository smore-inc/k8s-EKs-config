#K8s Dashboard
A nice UI view to explore and troubleshoot k8s issues. 

## Metrics Server Installation
Use data aggregator fo K8s cluster. Part of the default installation of a cluster. in EKS it's not part of the installation and need to be installed manually.

```shell
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```
Metrics Server data will be presented on k8s dashboard but also collected by datadog agent.

Based on [EKS user guide - Metrics Server](https://docs.aws.amazon.com/eks/latest/userguide/metrics-server.html).

##K8s Dashboard Installation
Deploy dashboard components:
```shell
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.5/aio/deploy/recommended.yaml
```
Create an eks-admin service account and cluster role binding:
```shell
kubectl apply -f eks-admin-service-account.yaml
``` 
Based on [EKS user guide - K8s dashboard](https://docs.aws.amazon.com/eks/latest/userguide/dashboard-tutorial.html)

## Launch Dashboard locally
Get token authentication:
```shell
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
```
Start proxy
```shell
kubectl proxy
```

Go to [local dashboard link](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#!/login) and use the generated token for authentication
