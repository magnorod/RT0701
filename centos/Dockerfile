FROM centos:latest

RUN echo "centos" > /etc/hostname\
&& yum install openssh-clients -y\
&& useradd superv\
&& echo "superv:superv" | chpasswd\
&& su -l superv\
&& echo "Host alpine" >> /home/superv/.ssh/config \
&& echo "   User superv" >> /home/superv/.ssh/config \
&& echo "   Hostname 172.18.10.10" >> /home/superv/.ssh/config

CMD echo "conteneur centos pret !"

