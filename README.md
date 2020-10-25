# awsKubernetes

The idea for this task is to create a cronjob that will find all ports on a Kubernetes environment.

There are several components from different environments that I will use.

## Kubernetes' files

For this part I will need several yaml files. From defining the service account, to cluster roles and finally the cron job.

Also if I have time I will include the files for the persistent volume and the persistent volume claim. Those will be basic to save the output of the script in a persistent and accesible way.

* Service account: Basic file to link the cron job with security files and volumes
* cluster role: Security file that defines what can a role do, I will start with open rules (not totally recommed since this allows a pod to do whatever it wants) Later I will define it in a more accuerate way to protect the environment
* role binding: To link the cluster role to a service account.
* cron job: Here will go most of the logic. For the first iterations I will use directly an image that contains kubectl and link it to a service account to get all permissions.

## Docker
On the first tries, I will use directly the following image: bitnami/kubectl:latest. This image already contains kubectl installed and won't need any extra configuration.

In following iterations I will create a Dockerfile with this image as base and I will include a script.

## Script
For the script I will use Bash for the following reasons, is light and almost every linux distro includes it.

## Actual steps to follow

1. Create service account
```
$ kubectl create -f serviceAccount.yaml
```
2. Create cluster role
```
$ kubectl create -f clusterRole.yaml
```
3. Create role binding
```
$ kubectl create -f roleBinding.yaml
```
4. Create cron job
```
$ kubectl create -f cronjob.yaml
```


For the moment the access to the results needs to be improved. To check the output the following steps are needed:

```
$ kubectl get jobs --watch
NAME                  COMPLETIONS   DURATION   AGE
getports-1603641300   0/1                      0s
getports-1603641300   0/1           0s         0s
```
This command will give a list of cronjobs. With one of the names we can check the output
```
$ pods=$(kubectl get pods --selectorob-name=getports-1603641300 --output=jsonpath={.items[*].metadata.name})

$ kubectl logs $pods
 ' kubernetes: 443

```

## Next steps

This is not an optimal solution, the next steps to take into account are the following:

* Create simple bash script to get the ports and save output on file.
* Create Dockerfile using as base the container from bitnami/kubectl to include the script.
* Create persistent volume and persistent volume claim to save the output file.
* Check if there is a way to bypass the namespace isolation in Kubernetes. Right now if I include the flag --all-namespaces it won't work.

