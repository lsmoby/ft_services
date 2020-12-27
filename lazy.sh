# docker container rm -f $(docker container ps -aq)
# docker image rm $(docker images -aq)
# docker build -t ft-nginx ./srcs/Nginx/
# docker run -it -p 80:80 -p 443:443 -p 2220:22  ft-nginx:latest /bin/bash
kubectl delete deployment nginx
kubectl delete service nginx-service
minikube delete
minikube start
sh setup.sh
