kubectl delete deployments --all
kubectl delete svc --all

eval $(minikube docker-env)

declare -a images=("influxdb" "mysql" "phpmyadmin" "wordpress" "nginx" "ftps" "grafana")
for image in "${images[@]}"
do
   docker build -t $image':ael-ghem' ./srcs/$image/
   kubectl apply -f ./srcs/$image'.yaml'
done