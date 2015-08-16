FROM gliderlabs/alpine:latest

MAINTAINER Wojciech Wójcik <wojtaswojcik@gmail.com>

ENV RABBITMQ_HOME=/opt/rabbitmq/ \
    RABBITMQ_NODENAME=node1 \
    RABBITMQ_VERSION=3.5.4 \
    PATH=/opt/rabbitmq/sbin/:$PATH \
    TIMEZONE=Europe/Warsaw

RUN apk -X http://dl-4.alpinelinux.org/alpine/edge/testing --update add erlang \
    erlang-sasl \
    openssl \
    erlang-os-mon \
    erlang-mnesia \
    erlang-eldap \
    erlang-inets \
    erlang-xmerl\
    tzdata && \
    mkdir -p /opt/rabbitmq && \
    wget -O /tmp/rabbitmq.tar.gz https://www.rabbitmq.com/releases/rabbitmq-server/v${RABBITMQ_VERSION}/rabbitmq-server-generic-unix-${RABBITMQ_VERSION}.tar.gz && \
    tar -C /tmp -xvzf /tmp/rabbitmq.tar.gz && \
    mv /tmp/rabbitmq_server-${RABBITMQ_VERSION}/* /opt/rabbitmq && \
    rm -rf /tmp/rabbitmq.tar.gz /tmp/rabbitmq_server-${RABBITMQ_VERSION} /var/cache/apk/* && \
    cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime && \
    echo "$TIMEZONE" >  /etc/timezone

EXPOSE 5672 12345 15671

VOLUME ["/opt/rabbitmq/etc"]

CMD ["/opt/rabbitmq/sbin/rabbitmq-server"]