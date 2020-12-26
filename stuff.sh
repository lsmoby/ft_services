eval $(minikube docker-env)
kubectl delete deployment nginx
kubectl delete service nginx-service
docker image rm -f nginx:ael-ghem
