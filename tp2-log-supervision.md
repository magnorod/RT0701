


docker run -it --hostname alpine-tp2-rt0701  --name alpine-tp2-rt0701 alpine-tp2-rt0701 /bin/ash


docker run -it --hostname debian-tp2-rt0701  --name debian-tp2-rt0701 debian-tp2-rt0701 /bin/bash


docker run -d --hostname centos-tp2-rt0701  --name centos-tp2-rt0701 centos-tp2-rt0701



docker build --rm -t centos-tp2-rt0701-systemd




 # RT0701 - TP2 Logs et supervison
 
 # Gestion des logs

SI pas d'erreur d'authentification Alors:
 
 * Sur chaque machine, stockage en local dans /var/log/opKO.log 
 pour les opérations (locale, SSH, su, sudo)

SINON

* stockage des logs sur le serveur Syslog-ng du conteneur debian


## Authentification OK


### Debian 

**installation de syslog-ng**

* apt-get install -y syslog-ng-core
* apt-get install -y syslog-ng


modification du fichier /etc/syslog-ng/syslog-ng.conf

**ajout de la destination:**
destination d_opOK { file("/var/log/opOK.log"); };

**ajout au niveau des filtres:**

filter f_opOK_local { facility(local0, local1, local2 local3, local4, local5, local6, local7 ) and not filter(f_err); };
filter f_opOK_ssh {facility(auth, authpriv) and match('^sshd\[[0-9]+\]:') and not filter(f_err); };
filter f_opOK_su {facility(auth, authpriv) and match('^su\[[0-9]+\]:') and not filter(f_err); };
filter f_opOK_sudo {facility(auth, authpriv) and match('^sudo\[[0-9]+\]:') and not filter(f_err); };


**ajout au niveau du log:**
log { source(s_src); filter(f_opOK_local); destination(d_opOK); };
log { source(s_src); filter(f_opOK_ssh); destination(d_opOK); };
log { source(s_src); filter(f_opOK_su); destination(d_opOK); };
log { source(s_src); filter(f_opOK_sudo); destination(d_opOK); };




**redémarrage de syslog-ng**
/etc/init.d/syslog-ng restart



### Alpine


apk add syslog-ng
/etc/init.d/syslog-ng start

modif /etc/syslog-ng/syslog-ng.conf

filter f_err { level(err); };

log { source(s_sys); filter(f_opOK_local); destination(d_opOK); };
log { source(s_sys); filter(f_opOK_ssh); destination(d_opOK); };
log { source(s_sys); filter(f_opOK_su); destination(d_opOK); };
log { source(s_sys); filter(f_opOK_sudo); destination(d_opOK); };



### Centos
 Installation d'EPEL (Extra Packages for Enterprise Linux )


 yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm


* yum install syslog-ng -y

exit

modif /etc/syslog-ng/syslog-ng.conf

filter f_err { level(err); };

log { source(s_sys); filter(f_opOK_local); destination(d_opOK); };
log { source(s_sys); filter(f_opOK_ssh); destination(d_opOK); };
log { source(s_sys); filter(f_opOK_su); destination(d_opOK); };
log { source(s_sys); filter(f_opOK_sudo); destination(d_opOK); };









### Architecture des fichiers sur le conteneur debian

