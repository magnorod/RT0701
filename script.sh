#! /bin/sh

    ssh superv@172.18.10.21 << INVITE
    touch resultat.txt
    adresse_ip = $(ip addr show dev eth0 | grep eth0 | grep inet | awk '{print $2}')
    espace_disque_dispo = $(df | awk '{print $4}')
    cpu = $(top -n1 -b | awk '{print $9}')
     
    text="
adresse ip :
$adresse_ip
    
espace disque dispo:
$espace_disque_dispo

cpu:
$cpu
"
 echo "$text">> resultat.txt

INVITE
    print "script terminé"