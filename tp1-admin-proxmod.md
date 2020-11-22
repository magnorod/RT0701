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

copie de la clé publique du conteneur Debian sur le conteneur Centos

ssh-copy-id -i /home/superv/.ssh/id_rsa.pub superv@172.18.10.20


Centos:
* accepte uniquement ssh depuis debian
* échange de clé 

### accepte uniquement ssh depuis debian 
modifier /etc/ssh/sshd_config

* PermitRootLogin no
* PubkeyAuthentication no  
* PasswordAuthentication no

ajouter à la fin du fichier:

Match Address 172.18.10.20  
    PubkeyAuthentication yes

### accepte uniquement superv
modifier /etc/ssh/sshd_config
* AllowUsers superv

### redémarrage de sshd
* systemctl restart sshd.service


problème connexion uniquement clé debian-> centos
