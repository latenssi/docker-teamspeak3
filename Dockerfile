FROM ubuntu:16.04

ENV TEAMSPEAK_VERSION 3.0.13.8
ENV TEAMSPEAK_URL http://dl.4players.de/ts/releases/${TEAMSPEAK_VERSION}/teamspeak3-server_linux_amd64-${TEAMSPEAK_VERSION}.tar.bz2

ENV TS3_UID 1000
ENV DEBIAN_FRONTEND noninteractive

ADD ${TEAMSPEAK_URL} /tmp/teamspeak3-server.tar.bz2

RUN tar --directory /opt/ -xvjf /tmp/teamspeak3-server.tar.bz2 && \
    rm /tmp/teamspeak3-server.tar.bz2 && \
    mkdir -p /data/logs && \
    ln -s /data/ts3server.sqlitedb /opt/teamspeak3-server_linux_amd64/ts3server.sqlitedb

RUN useradd -u ${TS3_UID} ts3 \
    && chown -R ts3 /opt/teamspeak3-server_linux_amd64 \
    && chown -R ts3 /data

VOLUME ["/data"]

EXPOSE 9987/udp 30033 10011

USER ts3

ENTRYPOINT ["/opt/teamspeak3-server_linux_amd64/ts3server_minimal_runscript.sh"]
CMD ["inifile=/data/ts3server.ini", "logpath=/data/logs","licensepath=/data/","query_ip_whitelist=/data/query_ip_whitelist.txt","query_ip_backlist=/data/query_ip_blacklist.txt"]
