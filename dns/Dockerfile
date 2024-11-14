# dns/Dockerfile
FROM ubuntu:latest
RUN apt-get update && apt-get install -y bind9
COPY named.conf.local /etc/bind/named.conf.local
COPY db.endrew.br /etc/bind/db.endrew.br
CMD ["named", "-g"]
