FROM centos:latest
RUN useradd superv --home /home/superv --create-home --shell /bin/bash\
&& mkdir /home/superv/.ssh\
&& echo "Host alpine" >> /home/superv/.ssh/config \
&& echo "   User superv" >> /home/superv/.ssh/config \
&& echo "   Hostname 172.18.10.10" >> /home/superv/.ssh/config\
&& mkdir /home/superv/.ssh/known_host\
&& yum install openssh-clients -y


