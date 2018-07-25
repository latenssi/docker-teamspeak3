FROM ubuntu:16.04

RUN apt-get update && apt-get install -y curl bzip2 && apt-get clean && rm -rf /var/lib/apt/lists

ENV TEAMSPEAK_VERSION 3.2.0
ENV TEAMSPEAK_URL http://dl.4players.de/ts/releases/${TEAMSPEAK_VERSION}/teamspeak3-server_linux_amd64-${TEAMSPEAK_VERSION}.tar.bz2

RUN cd /opt/ \
    && curl ${TEAMSPEAK_URL} | tar -xj \
    && mkdir -p /data/logs \
    && ln -s /data/ts3server.sqlitedb /opt/teamspeak3-server_linux_amd64/ts3server.sqlitedb

VOLUME ["/data"]

EXPOSE 9987/udp 30033 10011

ENTRYPOINT ["/opt/teamspeak3-server_linux_amd64/ts3server_minimal_runscript.sh"]
CMD ["inifile=/data/ts3server.ini", "logpath=/data/logs","licensepath=/data/","query_ip_whitelist=/data/query_ip_whitelist.txt","query_ip_backlist=/data/query_ip_blacklist.txt"]
