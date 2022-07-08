FROM debian:buster
MAINTAINER André Scholz <andre.scholz@ontavio.de>
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y mc zip pv nano tcptrack ssh sudo curl ffmpeg wget pv sudo build-essential rsync -y
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - \
        && sudo apt-get install -y nodejs

RUN npm install -g @angular/cli
COPY dr-strange/clients/assets/entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh
ENTRYPOINT ["/bin/entrypoint.sh"]
CMD [$ACTION]
