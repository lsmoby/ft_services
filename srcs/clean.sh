kubectl delete deployments --all
kubectl delete svc --all

# eval $(minikube docker-env)

# declare -a images=("mysql" "phpmyadmin" "wordpress" "nginx" "ftps" "influxdb" "grafana")
# for image in "${images[@]}"
# do
#    docker build -t $image':ael-ghem' ./srcs/$image/
#    kubectl apply -f ./srcs/$image'.yaml'
# done