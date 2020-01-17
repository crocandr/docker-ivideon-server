FROM ubuntu:xenial


RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl xfce4 icewm firefox xrdp gnupg wget pwgen rsync

RUN curl -L -o /etc/apt/sources.list.d/ivideon.list http://packages.ivideon.com/ubuntu/keys/ivideon.list && \
    curl -L -S http://packages.ivideon.com/ubuntu/keys/ivideon.key | apt-key add && \
    apt-get update && \
    apt-get install -y ivideon-video-server

COPY files/xrdp-template.ini /opt/xrdp-template.ini

COPY files/start.sh /opt/start.sh
RUN chmod 755 /opt/start.sh

EXPOSE 3389
VOLUME /home/ivideon/.IvideonServer

ENTRYPOINT /opt/start.sh
