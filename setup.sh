minikube start
#minikube dashboard
kubectl config use-context minikube
eval $(minikube docker-env)
	#building images
		docker build -t imagename:version ./path/dockerfile
	#creating deployement
		kubectl run nginx --image=nginx:ael-ghem --port=8080 --image-pull-policy=Never
		# or 
		kubectl create -f nginx.yaml
	#creating service
		kubectl expose deploy nginx-deployment --port 80 --type LoadBalancer


#                This will deploy MetalLB to cluste
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
# On first install only
# kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
