FROM alpine:latest

RUN adduser -h /home/superv -s /bin/sh -D superv superv\
&& mkdir /home/superv/.ssh\
&& echo "# alias pour la connexion" > /home/superv/.ssh/config \
&& echo "Host alpine" >> /home/superv/.ssh/config \
&& echo "   User superv" >> /home/superv/.ssh/config \
&& echo "   Hostname 172.18.10.10" >> /home/superv/.ssh/config\
&& apk add openssh-client 

CMD echo "conteneur alpine pret !"






