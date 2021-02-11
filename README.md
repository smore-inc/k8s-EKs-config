# k8s-EKs-config
Cluster and general environment configuration

cluster:
A basic end to end configuration based on EKS quick start(https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html).
resources:
Dedicated VPC with 4 subnets (2 public, 2 private) and the required network components.
EKS cluster with the required roles, and a single node group contains 3 nodes (t3.medium).

dashboard:
k8s visual dashboard extension based on (https://docs.aws.amazon.com/eks/latest/userguide/dashboard-tutorial.html)
pre installation: metrics server
post installation: service account to connect locally

in order to connect 
1) get token:
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
2) run proxy:
kubectl proxy
3) use link: http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#!/login
  
datadog agent:
base68 hashed token.
install an agent and grant permissions
    

 
 

