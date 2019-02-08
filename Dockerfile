FROM consol/ubuntu-xfce-vnc

USER 0

RUN apt-get update && apt-get install -y curl
RUN curl -L -o /etc/apt/sources.list.d/ivideon.list http://packages.ivideon.com/ubuntu/keys/ivideon.list && \
    curl -L -S http://packages.ivideon.com/ubuntu/keys/ivideon.key | apt-key add && \
    apt-get update && \
    apt-get install -y ivideon-video-server
COPY files/supervisor-ivideon-server.conf /etc/supervisor/conf.d
COPY files/supervisor-startup.sh /dockerstartup/

## switch back to default user
USER 1000
