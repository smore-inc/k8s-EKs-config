#datadog deployment
kubectl apply -f datadog/datadog-agent.yaml
kubectl apply -f datadog/permissions.yaml

# metrics server deployment
kubectl apply -f dashboard/metrics-server.yaml
kubectl apply -f dashboard/dashboard.yaml
kubectl apply -f dashboard/eks-admin-service-account.yaml
# print token
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
