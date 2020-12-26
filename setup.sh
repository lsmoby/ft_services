# ----------------------- install brew in goinfre -----------------------

export MACHINE_STORAGE_PATH="/goinfre/$USER/.docker"
export MINIKUBE_HOME="/goinfre/$USER/.minikube"


if ! command -v brew &> /dev/null
then
  export HOME_BREW="/goinfre/$USER"
  rm -rf $HOME/.brew && rm -rf $HOME_BREW/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME_BREW/.brew && export PATH=$HOME_BREW/.brew/bin:$PATH && brew update && echo "export PATH=$HOME_BREW/.brew/bin:$PATH" >> ~/.zshrc && echo "export MINIKUBE_HOME=\"/goinfre/$USER/.minikube\"" >> ~/.zshrc  && echo export "MACHINE_STORAGE_PATH=\"/goinfre/$USER/.docker\"" >> ~/.zshrc
	echo	"export HOME_BREW=\"/goinfre/$USER\""	>> ~/.zshrc
	echo	"export PATH=$HOME_BREW/.brew/bin:$PATH"
	echo	"export MACHINE_STORAGE_PATH=\"/goinfre/$USER/.docker\""	>> ~/.zshrc
	echo	"export MINIKUBE_HOME=\"/goinfre/$USER/.minikube\""	>> ~/.zshrc
	echo	"export MACHINE_STORAGE_PATH=\"/goinfre/$USER/.docker\""	>> ~/.zshrc

fi

# ----------------------- install docker -----------------------

if ! command -v docker &> /dev/null
then
	brew install docker
fi

# ----------------------- install kubectl -----------------------

if ! command -v kubectl &> /dev/null
then
	brew install kubectl
fi

# -----------------------  install minikube -----------------------

if ! command -v minikube &> /dev/null
then
	brew install minikube
	minikube addons enable dashboard
	minikube addons enable ingress
	minikube addons enable metrics-server
fi

# ----------------------- starting minikube  ----------------------- 

if ! command minikube status | grep Running &>/dev/null
then
	minikube start
fi


# ----------------------- building images -----------------------

kubectl config use-context minikube
eval $(minikube docker-env)

if ! command docker images | grep nginx | grep ael-ghem &> /dev/null
then
	docker build -t nginx:ael-ghem ./srcs/nginx/.
fi

# ----------------------- creating deployements ----------------------- 
	#	kubectl run nginx --image=nginx:ael-ghem --po0rt=8080 --image-pull-policy=Never
		# or 
	kubectl create -f ./srcs/nginx.yaml

# ----------------------- creating services ----------------------- 
		#kubectl expose deploy nginx-deployment --port 80 --type LoadBalancer
		#or
	kubectl create -f ./srcs/nginx-service.yaml


#                This will deploy MetalLB to cluste
if ! command kubectl get ClusterRole | grep metallb &> /dev/null
then
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
	kubectl create -f ./srcs/metalLB.yaml
		# On first install only
	if ! command kubectl get secret -A | grep metallb | grep memberlist &> /dev/null
	then
		kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
	fi
fi
