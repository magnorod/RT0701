FROM alpine:latest

RUN echo "alpine" > /etc/hostname\
&& apk add openssh-client\
&& adduser -D superv\
&& echo "superv:superv" | chpasswd\
&& echo "# alias pour la connexion" >> /home/superv/.ssh/config \
&& echo "Host ubuntu" >> /home/superv/.ssh/config \
&& echo "   User superv" >> /home/superv/.ssh/config \
&& echo "   Hostname 172.18.10.10" >> /home/superv/.ssh/config

CMD echo "conteneur alpine pret !"






