FROM ubuntu
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && apt-get install -y nfs-kernel-server runit inotify-tools -qq
RUN mkdir -p /exports


RUN mkdir -p /etc/sv/nfs

ADD nfs.init /etc/sv/nfs/run
RUN cat /etc/sv/nfs/run | tr -d '\r' > /etc/sv/nfs/run
RUN chmod +x /etc/sv/nfs/run

ADD nfs.stop /etc/sv/nfs/finish
RUN cat /etc/sv/nfs/finish | tr -d '\r' > /etc/sv/nfs/finish
RUN chmod +x /etc/sv/nfs/finish

ADD nfs_setup.sh /usr/local/bin/nfs_setup
RUN cat /usr/local/bin/nfs_setup | tr -d '\r' > /usr/local/bin/nfs_setup
RUN chmod +x /usr/local/bin/nfs_setup

RUN echo "nfs             2049/tcp" >> /etc/services
RUN echo "nfs             111/udp" >> /etc/services

VOLUME /exports

EXPOSE 111/udp 2049/tcp

#RUN ["/usr/local/bin/nfs_setup", "/home", "/opt"]

#ENTRYPOINT ["runsvdir", "/etc/sv"]
