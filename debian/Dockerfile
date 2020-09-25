FROM debian:latest

ADD . /app

WORKDIR /app

RUN apt-get update -y\ 
&& apt-get install nano -y\
&& useradd superv --home /home/superv --create-home --shell /bin/bash\
&& echo "superv:superv" | chpasswd
&& apt-get install openssh-server -y\
&& apt-get update -y\
&& chmod u+x tp1-script.sh\
&& ./tp1-script.sh

CMD echo "conteneur debian pret !"
