FROM ubuntu:14.04

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV TEAMSPEAK_VERSION 3.0.12.2
ENV TEAMSPEAK_URL http://dl.4players.de/ts/releases/${TEAMSPEAK_VERSION}/teamspeak3-server_linux_amd64-${TEAMSPEAK_VERSION}.tar.bz2
ENV DEBIAN_FRONTEND noninteractive

ADD ${TEAMSPEAK_URL} /tmp/teamspeak3-server.tar.bz2

RUN tar --directory /opt/ -xvjf /tmp/teamspeak3-server.tar.bz2 && \
    rm /tmp/teamspeak3-server.tar.bz2 && \
    mkdir -p /data/logs && \
    ln -s /data/ts3server.sqlitedb /opt/teamspeak3-server_linux_amd64/ts3server.sqlitedb

VOLUME ["/data"]

EXPOSE 9987/udp 30033 10011

ENTRYPOINT ["/opt/teamspeak3-server_linux_amd64/ts3server_minimal_runscript.sh"]
CMD ["inifile=/data/ts3server.ini", "logpath=/data/logs","licensepath=/data/","query_ip_whitelist=/data/query_ip_whitelist.txt","query_ip_backlist=/data/query_ip_blacklist.txt"]
