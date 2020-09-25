## RT701 TP1-Configuration et commandes

### Architecture
Utilisation de docker pour ce TP donc 1 conteneur par OS




run d'un conteneur en mode privilège
docker run -i -d -t --privileged --network=mynetwork-1 debian

docker run -idt --privileged --network=mynetwork-1 --ip 172.18.10.10 debian-v2 /bin/bash

docker start -i conteneur

### Configuration réseau


### création des utilisateurs et configuration des accès



ajout de l'utilisateur superv
**adduser superv**

#PermitRootLogin prohibit-password


accès SSH: 
1) installer le serveur ssh sur le conteneur debian 
**apt install openssh-server**


modification du fichier de configuration du serveur ssh

nano /etc/ssh/sshd_config
1) refuser les connexions en root
décommenter PermitRootLogin yes et mettre
**PermitRootLogin no**

désactivation de root



2) accepter uniquement les connexions de l'utilisateur superv
ajouter la ligne **AllowUsers superv**





