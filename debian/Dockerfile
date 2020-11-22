FROM debian:latest

ADD . /app

WORKDIR /app

RUN apt-get update -y\
&& echo "debian" > /etc/hostname\
&& apt-get install openssh-server -y\
&& chmod u+x tp1-script.sh\
&& ./tp1-script.sh\
&& useradd superv\
&& echo "superv:superv" | chpasswd\
&& service ssh restart

CMD echo "conteneur debian pret !"
