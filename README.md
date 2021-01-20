# 42 services project
    Summary: This is a System Administration and Networking project.
            The project consists of setting up an infrastructure of different services.
            using Kubernetes. this is a set up to a multi-service cluster.
    Services:
            mysql-server with phpmyadmin control panel, ftps-server,
                ssh server, nginx server, wordpress ready.
        
            for cluster monitoring: InfluxDB, Telegraf, Grafana
            all of the deployments are using the same address ip,
                which is managed by Loadbalancer (MetalLB)
            all of the images used are built from scratch using alpine linux base image.
## usage

####   -----------nginx----------
#ssh	root@192.168.99.110

#ssh password:	toor

####   -----------ftps-----------
#user   	ael-ghem
#password	password

####   -----------mysql----------
#user   	ael-ghem
#password	password

####   -----------grafana--------
#user		admin
#password	admin
