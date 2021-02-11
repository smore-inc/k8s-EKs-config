#Cluster installation 
Based on [AWS User guide](https://docs.aws.amazon.com/eks/latest/userguide). on each step the relevant part is mentioned.

A full, unified CloudFormation stack [cluster.yaml](cluster.yaml) with all the required resources exists. At the beginging of each step the name of the corresponding resources is mentioned.   

##Pre-install
###VPC and Network
Resource name: *VPC*

As described on [Creating a VPC for your Amazon EKS cluster](https://docs.aws.amazon.com/eks/latest/userguide/create-public-private-vpc.html)
using the cloudFormation stack [amazon-eks-vpc-private-subnets.yaml](https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/amazon-eks-vpc-private-subnets.yaml)
(as for now installed using the exists default VPC so nothing installed).

###Security Group.
Resource name: *ControlPlaneSecurityGroup*

A security group for the cluster to communicate with worker nodes.
Also part of the VPC example described in [Creating a VPC for your Amazon EKS cluster](https://docs.aws.amazon.com/eks/latest/userguide/create-public-private-vpc.html) but this time a dedicated security group is the preferred option.
###Cluster Role
Resource name: *EKSClusterRole*:

Based on [EKS cluster role](https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html)
  
##Cluster Install
Resource name: *Cluster*

Setting the mentioned VPC, security group, and role from pre-install phase.


##Post-install
###role creation
Resource name: *NodeInstanceRole*

based on [EKS node role](https://docs.aws.amazon.com/eks/latest/userguide/create-node-role.html)

###node group creation
Resource name: *EKSNodegroup*

The EC2 instances nodes definition.
Uses the role created on previous step


#Operate K8s Locally
After creating a cluster and before starting deploy, some more actions required.
##Grant access
By default, EKS configured to enable access for the creator only (AWS user).
Few steps in order to enable communicate with cluster using kubectl.
###Prerequisites
- AWS CLI
- kubectl
###Update kubectl config
adding the new cluster to kubeconfig 

```shell
aws eks --region <region-code> update-kubeconfig --name <cluster_name>
```
###Adding AWS User
Trying to edit configmap with the following command:

```shell
kubectl edit configmap aws-auth -n kube-system
```
 
If not exists, adding config map using:

```shell
kubectl apply -f aws-auth-cm.yaml
```

The required result should be as following ([template source](https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/aws-auth-cm.yaml)):
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: | 
    ## user template
    - groups:
      - system:masters
      rolearn: [user arn]
      username: [user name]
    ## buildkite user
    - groups:
      - system:masters
      rolearn: arn:aws:iam::487298505244:user/buildkite-worker-user
      username: buildkite-worker-user
  ```

#More
##Namespaces
use [namespaces.yml](namespace.yml) to deploy namespaces. The selected practice is to have production and staging on the same cluster with different namespace.
##Buildkite Deploy
Buildkite deployment based on the assumption that environment name and branch name are the same for "production" and "staging".  
the only requirement is to grant buildkite access (as described on [Adding AWS user]()).