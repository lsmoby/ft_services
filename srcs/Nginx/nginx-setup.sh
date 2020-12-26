docker image rm $(docker images -aq)
docker container rm -f $(docker container ps -aq)
docker build -t ft-nginx:ael-ghem ./srcs/Nginx/
docker run -d -p 80:80 -p 443:443 -p 2220:22 --name ft-nginx --hostname ft-nginx ft-nginx:ael-ghem
sleep 2
docker cp ft-nginx:/etc/ssh/ssh_host_rsa_key.pub ./srcs
ssh-keygen -p ./srcs/ssh_host_rsa_key.pub -i 2220 -R sshadmin@192.168.99.104
#test ssh
# ssh-keygen -R {ip}
#ssh -p 2220 -i ./srcs/ssh_host_rsa_key.pub sshadmin@{ip}