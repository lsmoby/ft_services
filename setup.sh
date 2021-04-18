#!/bin/sh


echo "\033[0;34m      :::::::::: :::::::::::           ::::::::  :::::::::: :::::::::  :::     ::: ::::::::::: ::::::::  :::::::::: :::::::: 
     :+:            :+:              :+:    :+: :+:        :+:    :+: :+:     :+:     :+:    :+:    :+: :+:       :+:    :+: 
    +:+            +:+              +:+        +:+        +:+    +:+ +:+     +:+     +:+    +:+        +:+       +:+         
   :#::+::#       +#+              +#++:++#++ +#++:++#   +#++:++#:  +#+     +:+     +#+    +#+        +#++:++#  +#++:++#++   
  +#+            +#+                     +#+ +#+        +#+    +#+  +#+   +#+      +#+    +#+        +#+              +#+    
 #+#            #+#              #+#    #+# #+#        #+#    #+#   #+#+#+#       #+#    #+#    #+# #+#       #+#    #+#     
###            ###    ########## ########  ########## ###    ###     ###     ########### ########  ########## ########\033[0m"

# ----------------------- install brew in goinfre -----------------------


if ! command -v brew &> /dev/null
then
  export HOME_BREW="/goinfre/$USER"
  rm -rf $HOME/.brew && rm -rf $HOME_BREW/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME_BREW/.brew && export PATH=$HOME_BREW/.brew/bin:$PATH && brew update
	echo	"export PATH=$HOME_BREW/.brew/bin:$PATH" >> ~/.zshrc
	echo	"export MINIKUBE_HOME=\"/goinfre/$USER/.minikube\"" >> ~/.zshrc
	echo	"export MACHINE_STORAGE_PATH=\"/goinfre/$USER/.docker\"" >> ~/.zshrc
	echo	"export HOME_BREW=\"/goinfre/$USER\""	>> ~/.zshrc
	echo	"export MACHINE_STORAGE_PATH=\"/goinfre/$USER/.docker\""	>> ~/.zshrc
	echo	"export MINIKUBE_HOME=\"/goinfre/$USER/.minikube\""	>> ~/.zshrc
	echo	"export MACHINE_STORAGE_PATH=\"/goinfre/$USER/.docker\""	>> ~/.zshrc
fi

# ----------------------- install kubectl -----------------------

if ! command -v kubectl &> /dev/null
then
	echo "\033[0;31m installing kubectl... \033[0m"
	brew install kubectl
fi

# ----------------------- install docker-machine -----------------------

if ! command -v docker &> /dev/null
then
	echo "\033[0;31m installing docker... \033[0m"
	brew install docker
fi


# -----------------------  install minikube -----------------------
	
if ! command -v minikube &> /dev/null
then
	echo "\033[0;31m installing minikube... \033[0m"
	brew install minikube
fi

# ----------------------- starting minikube  ----------------------- 
	echo "\033[0;31m starting minikube... \033[0m"
if ! command minikube status | grep Running &>/dev/null
then
	minikube start --driver=virtualbox
	minikube addons enable dashboard
	minikube addons enable metrics-server
fi


# ----------------------- building images, creating deployments and services -----------------------

	echo "\033[0;31m building images, creating deployments and services \033[0m"
	kubectl config use-context minikube
	eval $(minikube docker-env)
	docker pull metallb/controller:v0.9.5
	docker pull metallb/speaker:v0.9.5

declare -a images=("influxdb" "mysql" "phpmyadmin" "wordpress" "nginx" "ftps" "grafana")
for image in "${images[@]}"
do
   docker build -t $image':ael-ghem' ./srcs/$image/
   kubectl apply -f ./srcs/$image'.yaml'
done

# ----------------------- creating deployements and services ----------------------- 

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

#-----------nginx----------
#ssh	root@192.168.99.110
#ssh password:	toor
#-----------ftps-pma-------
#user   	ael-ghem
#password	password
#-----------mysql----------
#user   	ael-ghem
#password	password
#-----------grafana--------
#user		admin
#password	admin
#-----------WP-------------
#user		admin
#password	Password