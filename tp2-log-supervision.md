


# RT0701 - TP2 Logs et supervison
 
 # Gestion des logs

## authentification OK

### Debian 

#### installation de syslog-ng

* apt-get install -y syslog-ng-core
* apt-get install -y syslog-ng


#### modification du fichier /etc/syslog-ng/syslog-ng.conf 


destination d_opOK { file("/var/log/opOK.log"); };

filter f_opOK_local { facility(local0, local1, local2 local3, local4, local5, local6, local7 ) and not filter(f_err); };
filter f_opOK_ssh {facility(auth, authpriv) and match('^sshd\[[0-9]+\]:') and not filter(f_err); };
filter f_opOK_su {facility(auth, authpriv) and match('^su\[[0-9]+\]:') and not filter(f_err); };
filter f_opOK_sudo {facility(auth, authpriv) and match('^sudo\[[0-9]+\]:') and not filter(f_err); };


log { source(s_src); filter(f_opOK_local); destination(d_opOK); };
log { source(s_src); filter(f_opOK_ssh); destination(d_opOK); };
log { source(s_src); filter(f_opOK_su); destination(d_opOK); };
log { source(s_src); filter(f_opOK_sudo); destination(d_opOK); };


#### redémarrage de syslog-ng
/etc/init.d/syslog-ng restart



### Alpine

#### installation de syslog-ng

* apk add syslog-ng
* /etc/init.d/syslog-ng start

modif /etc/syslog-ng/syslog-ng.conf


destination d_opOK { file("/var/log/opOK.log"); };

filter f_err { level(err); };

filter f_opOK_local { facility(local0, local1, local2 local3, local4, local5, local6, local7 ) and not filter(f_err); };
filter f_opOK_ssh {facility(auth, authpriv) and match('^sshd\[[0-9]+\]:') and not filter(f_err); };
filter f_opOK_su {facility(auth, authpriv) and match('^su\[[0-9]+\]:') and not filter(f_err); };
filter f_opOK_sudo {facility(auth, authpriv) and match('^sudo\[[0-9]+\]:') and not filter(f_err); };

log { source(s_sys); filter(f_opOK_local); destination(d_opOK); };
log { source(s_sys); filter(f_opOK_ssh); destination(d_opOK); };
log { source(s_sys); filter(f_opOK_su); destination(d_opOK); };
log { source(s_sys); filter(f_opOK_sudo); destination(d_opOK); };

### Centos
 
#### installation d'EPEL (Extra Packages for Enterprise Linux )


* yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
* yum install syslog-ng -y


modif /etc/syslog-ng/syslog-ng.conf


destination d_opOK { file("/var/log/opOK.log"); };

filter f_err { level(err); };
filter f_opOK_local { facility(local0, local1, local2 local3, local4, local5, local6, local7 ) and not filter(f_err); };
filter f_opOK_ssh {facility(auth, authpriv) and match('^sshd\[[0-9]+\]:') and not filter(f_err); };
filter f_opOK_su {facility(auth, authpriv) and match('^su\[[0-9]+\]:') and not filter(f_err); };
filter f_opOK_sudo {facility(auth, authpriv) and match('^sudo\[[0-9]+\]:') and not filter(f_err); };

log { source(s_sys); filter(f_opOK_local); destination(d_opOK); };
log { source(s_sys); filter(f_opOK_ssh); destination(d_opOK); };
log { source(s_sys); filter(f_opOK_su); destination(d_opOK); };
log { source(s_sys); filter(f_opOK_sudo); destination(d_opOK); };





## envoi des erreurs sur le serveur syslog debian

### Centos et Alpine

destination d_debian { tcp("192.168.1.1" port(9999)); };

filter f_local_err { facility(local0, local1, local2 local3, local4, local5, local6, local7 ) and filter(f_err); };
filter f_ssh_err {facility(auth, authpriv) and match('^sshd\[[0-9]+\]:') and filter(f_err); };
filter f_su_err {facility(auth, authpriv) and match('^su\[[0-9]+\]:') and filter(f_err); };
filter f_sudo_err {facility(auth, authpriv) and match('^sudo\[[0-9]+\]:') and filter(f_err); };


log { source(s_sys); filter(f_ssh_err); destination(d_debian); };
log { source(s_sys); filter(f_su_err); destination(d_debian); };
log { source(s_sys); filter(f_sudo_err); destination(d_debian); };
log { source(s_sys); filter(f_local_err); destination(d_debian); };

### Debian

source s_net { tcp(ip(192.168.1.1) port(9999)); };

destination d_centos_ssh { file("/var/log/centos/ssh-err.log");};
destination d_centos_su { file("/var/log/centos/su-err.log");};
destination d_centos_sudo { file("/var/log/centos/sudo-err.log");};
destination d_centos_locales { file("/var/log/centos/locales-err.log");};

destination d_alpine_ssh { file("/var/log/alpine/ssh-err.log");};
destination d_alpine_su { file("/var/log/alpine/su-err.log");};
destination d_alpine_sudo { file("/var/log/alpine/sudo-err.log");};
destination d_alpine_locales { file("/var/log/alpine/locales-err.log");};

destination d_debian_ssh { file("/var/log/debian/ssh-err.log");};
destination d_debian_su { file("/var/log/debian/su-err.log");};
destination d_debian_sudo { file("/var/log/debian/sudo-err.log");};
destination d_debian_locales { file("/var/log/debian/locales-err.log");};


filter f_local_err { facility(local0, local1, local2 local3, local4, local5, local6, local7 ) and filter(f_err); };
filter f_ssh_err {facility(auth, authpriv) and match('^sshd\[[0-9]+\]:') and filter(f_err); };
filter f_su_err {facility(auth, authpriv) and match('^su\[[0-9]+\]:') and filter(f_err); };
filter f_sudo_err {facility(auth, authpriv) and match('^sudo\[[0-9]+\]:') and filter(f_err); };


log { source(s_net); filter(f_ssh_err); destination(d_centos_ssh ); };
log { source(s_net); filter(f_su_err); destination(d_centos_su); };
log { source(s_net); filter(f_sudo_err); destination(d_centos_sudo); };
log { source(s_net); filter(f_local_err); destination(d_centos_locales); };

log { source(s_net); filter(f_ssh_err); destination(d_alpine_ssh ); };
log { source(s_net); filter(f_su_err); destination(d_alpine_su); };
log { source(s_net); filter(f_sudo_err); destination(d_alpine_sudo); };
log { source(s_net); filter(f_local_err); destination(d_alpine_locales); };

log { source(s_net); filter(f_ssh_err); destination(d_debian_ssh ); };
log { source(s_net); filter(f_su_err); destination(d_debian_su); };
log { source(s_net); filter(f_sudo_err); destination(d_debian_sudo); };
log { source(s_net); filter(f_local_err); destination(d_debian_locales); };


# Supervision

## Installation 

**Centos (Network Management Station)**
yum -y install net-snmp net-snmp-utils net-snmp-libs

autoriser le port 161 en udp ua niveau du parefeu 

firewall-cmd --add-port=161/udp --permanent
firewall-cmd --reload

**Debian**
apt install -y snmpd

**Alpine**
apk add net-snmpd

## configuration des infos de base
modifier le fichier /etc/snmp/snmpd.conf
sysContact     Marc Bourset-Marcellas <marcboursetmarcellas@test.org>


## récupération d'info (requête SNMP)

rmq: **snmpget** permet de récupérer les valeurs d'un ObjectIDentifier (feuille)
**snmpwalk** permet de récupérer tous les OID associés à un  sous arbre 


**test récolte info debian**
snmpget -c public -v 2c 192.168.1.1 system.sysUpTime.0

resultat:
DISMAN-EVENT-MIB::sysUpTimeInstance = Timeticks: (245296) 0:40:52.96




**coordonne admin machine debian**
snmpget -c public -v 2c 192.168.1.1 system.sysContact

resultat:
SNMPv2-MIB::sysContact.0 = STRING: Marc Bourset-Marcellas <marcboursetmarcellas@test.org>


**mémoire dispo (RAM)**
snmpwalk -c public -v 2c 192.168.1.1 UCD-SNMP-MIB::memTotalFree

resultat;
UCD-SNMP-MIB::memTotalFree.0 = INTEGER: 1806216 kB


**mémoire totale (RAM)**
snmpwalk -c public -v 2c 192.168.1.1 UCD-SNMP-MIB::memTotalReal

resultat:
UCD-SNMP-MIB::memTotalReal.0 = INTEGER: 8030156 kB 

**info cpu**
 snmpwalk -c public -v 2c 192.168.1.1 UCD-SNMP-MIB::systemStats

 resultat:
UCD-SNMP-MIB::ssIndex.0 = INTEGER: 1
UCD-SNMP-MIB::ssErrorName.0 = STRING: systemStats
UCD-SNMP-MIB::ssSwapIn.0 = INTEGER: 0 kB
UCD-SNMP-MIB::ssSwapOut.0 = INTEGER: 0 kB
UCD-SNMP-MIB::ssIOSent.0 = INTEGER: 1175 blocks/s
UCD-SNMP-MIB::ssIOReceive.0 = INTEGER: 47 blocks/s
UCD-SNMP-MIB::ssSysInterrupts.0 = INTEGER: 1765 interrupts/s
UCD-SNMP-MIB::ssSysContext.0 = INTEGER: 9683 switches/s
UCD-SNMP-MIB::ssCpuUser.0 = INTEGER: 7
UCD-SNMP-MIB::ssCpuSystem.0 = INTEGER: 1
UCD-SNMP-MIB::ssCpuIdle.0 = INTEGER: 89
UCD-SNMP-MIB::ssCpuRawUser.0 = Counter32: 2197860
UCD-SNMP-MIB::ssCpuRawNice.0 = Counter32: 28762
UCD-SNMP-MIB::ssCpuRawSystem.0 = Counter32: 1113469
UCD-SNMP-MIB::ssCpuRawIdle.0 = Counter32: 30670912
UCD-SNMP-MIB::ssCpuRawWait.0 = Counter32: 27238
UCD-SNMP-MIB::ssCpuRawKernel.0 = Counter32: 0
UCD-SNMP-MIB::ssCpuRawInterrupt.0 = Counter32: 0
UCD-SNMP-MIB::ssIORawSent.0 = Counter32: 81141256
UCD-SNMP-MIB::ssIORawReceived.0 = Counter32: 37292668
UCD-SNMP-MIB::ssRawInterrupts.0 = Counter32: 90518622
UCD-SNMP-MIB::ssRawContexts.0 = Counter32: 437763697
UCD-SNMP-MIB::ssCpuRawSoftIRQ.0 = Counter32: 323833
UCD-SNMP-MIB::ssRawSwapIn.0 = Counter32: 30568
UCD-SNMP-MIB::ssRawSwapOut.0 = Counter32: 195393
UCD-SNMP-MIB::ssCpuRawSteal.0 = Counter32: 0
UCD-SNMP-MIB::ssCpuRawGuest.0 = Counter32: 0
UCD-SNMP-MIB::ssCpuRawGuestNice.0 = Counter32: 0
UCD-SNMP-MIB::ssCpuNumCpus.0 = INTEGER: 8


**afficher tous les paquets installés sur la machine debian**
snmpwalk -c public -v 2c 192.168.1.1 HOST-RESOURCES-MIB::hrSWInstalledName

resultat:
HOST-RESOURCES-MIB::hrSWInstalledName.0 = STRING: "adduser-3.118"
HOST-RESOURCES-MIB::hrSWInstalledName.1 = STRING: "apt-1.8.2.2"
HOST-RESOURCES-MIB::hrSWInstalledName.2 = STRING: "base-files-10.3+deb10u7"
HOST-RESOURCES-MIB::hrSWInstalledName.3 = STRING: "base-passwd-3.5.46"
HOST-RESOURCES-MIB::hrSWInstalledName.4 = STRING: "bash-5.0-4"
HOST-RESOURCES-MIB::hrSWInstalledName.5 = STRING: "bsd-mailx-8.1.2-0.20180807cvs-1"
HOST-RESOURCES-MIB::hrSWInstalledName.6 = STRING: "bsdutils-1:2.33.1-0.1"
HOST-RESOURCES-MIB::hrSWInstalledName.7 = STRING: "bzip2-1.0.6-9.2~deb10u1"
HOST-RESOURCES-MIB::hrSWInstalledName.8 = STRING: "ca-certificates-20200601~deb10u1"
HOST-RESOURCES-MIB::hrSWInstalledName.9 = STRING: "coreutils-8.30-3"
HOST-RESOURCES-MIB::hrSWInstalledName.10 = STRING: "cron-3.0pl1-134+deb10u1"
etc.....

**afficher le nb d' utilisateurs connecté sur la  machine debian**
snmpwalk -c public -v 2c 192.168.1.1 HOST-RESOURCES-MIB::hrSystemNumUsers

resultat:
HOST-RESOURCES-MIB::hrSystemNumUsers.0 = Gauge32: 1
