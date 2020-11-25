## TP1- RT0701 

## Création utilisateur

### installation du serveur ssh 

Alpine:
* apk add openssh
* rc-update add sshd
* /etc/init.d/sshd start


Debian:
* sudo apt install openssh-server -y
* service ssh restart


Centos:
* yum install sudo -y (en root)

ajout de l'utilisateur M1RTA-3 au sudoers
* usermod -aG wheel M1RTA-3

* sudo yum install openssh-server -y

* systemctl restart sshd.service


### création de l'utilisateur superv

password for superv =123456

Alpine:

* adduser superv -D -s /bin/sh
* passwd superv
123456

Debian:
* useradd superv -s /bin/bash
* passwd superv
123456

Centos:
* useradd superv -s /bin/bash
* passwd superv
123456


## Configuration des accès

Debian:
* refus des connexions en tant que root
* accepte uniquement superv

### refus des connexions en tant que root

modifier /etc/ssh/sshd_config

* PermitRootLogin no

### accepte uniquement superv
modifier /etc/ssh/sshd_config
* AllowUsers superv

### redémarrage du service ssh
* service ssh restart



Alpine:
* accepte uniquement ssh depuis debian
* accepte uniquement superv



### accepte uniquement ssh depuis debian
modifier /etc/ssh/sshd_config

* PermitRootLogin no
* PubkeyAuthentication no  
* PasswordAuthentication no

ajouter à la fin du fichier:

Match Address 172.18.10.20  
    PubkeyAuthentication yes
    PasswordAuthentication yes


### accepte uniquement superv
modifier /etc/ssh/sshd_config
* AllowUsers superv
    
### redémarrage de sshd
*/etc/init.d/sshd restart


### Génération d'une paire de clé sur la machine Debian


* ssh-keygen -t rsa

### copie de la clé publique du conteneur Debian sur le conteneur Centos

ssh-copy-id -i ~/.ssh/id_rsa.pub superv@172.18.10.21

Centos:
* accepte uniquement ssh depuis debian
* échange de clé 


### génération d'une paire de clé sur la machine centos

* ssh-keygen -t rsa

### copie de la clé publique du conteneur centos sur le conteneur debian

ssh-copy-id -i ~/.ssh/id_rsa.pub superv@172.18.10.20



### accepte uniquement ssh depuis debian 
modifier /etc/ssh/sshd_config

* PermitRootLogin no
* PubkeyAuthentication no  
* PasswordAuthentication no
* ChallengeResponseAUthentification no


ajouter à la fin du fichier:

Match Address 172.18.10.20  
    PubkeyAuthentication yes

### accepte uniquement superv
modifier /etc/ssh/sshd_config
* AllowUsers superv

### redémarrage de sshd
* systemctl restart sshd.service

## Commande de contrôle d'exécution

### extraire l'adresse ip d'une machine

* ip addr show dev eth0 | grep eth0 | grep inet | awk '{print $2}'

### l'espace disque disponible
 
* df | awk '{print $4}'


## afficher la charge CPU instantanée

top -n1 -b | awk '{print $9}'


## Collecte distante

1) Démarrage commande debian -> connexion ssh -> commande sur centos
2) Centos sauvegarde le résultat des commandes dans un fichier
3) envoi du fichier via scp dans le /tmp du conteneur debian

## Exécution des commandes

script de base à  éxécuter sur Debian:

![](script-debian.png)

qui va faire appel à ce script sur Centos:

![](script-centos.png)

résultat final:

![](resultat-script-centos.png)


Pour effectuer le script sur la machine debian toutes les 5 minutes, on va utiliser le démon CRON

ajout d'une règle crontab

![](crontab.png)


## Répertoire réseau partage


partager un répertoire de la machine debian vers alpine et centos

sur debian:

* sudo apt install samba -y && apt install smbclient

mkdir dossier-partage
touch dossier-partage/test.txt

nano /etc/samba/smb.conf




chown -R superv:superv /home/superv/dossier-partage/

chmod -R 770 /home/superv/dossier-partage/


ajouter l'utilisateur superv aux utilisateurs samba:
* smbpasswd -a superv

lister les utilisateurs samba:
* pdbedit -w -L

pour accéder à l'ensemble du répertoire partagé /home/superv
* smbclient //Debian-RT0701/superv


sur centos
yum install samba -y (en root)

dans /etc/fstab
//Debian-RT0701/dossier-partage     /media/partage-samba     cifs     _netdev,superv     0     0

sudo mount -a

sur alpine:
apk add samba 










