#!/bin/bash

sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
echo "INFO SCRIPT-connexion SSH Root désactivée"

echo "AllowUsers superv" >> /etc/ssh/sshd_config
echo "INFO SCRIPT-connexion SSH uniquement pour l'utilisateur superv"