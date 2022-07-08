FROM debian:buster
MAINTAINER André Scholz <andre.scholz@ontavio.de>
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y mc zip pv nano tcptrack ssh sudo curl ffmpeg wget pv sudo build-essential -y
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - \
        && sudo apt-get install -y nodejs

ARG ACTION="dev"
# copy standard stuff
RUN mkdir -p /home/stuff && chmod 0777 /home/stuff
COPY assets/.bash_aliases /home/stuff/.bash_aliases
RUN mkdir -p /home/stuff/root && cp -a /root /home/stuff
COPY assets/.bashrc-addings /home/stuff/.bashrc-addings
RUN cat /home/stuff/root/.bashrc /home/stuff/.bashrc-addings > /home/stuff/.bashrc
RUN mkdir -p /home/swap && chmod 0777 /home/swap

EXPOSE 4200 4300
RUN npm install -g @angular/cli
COPY dr-strange/clients/assets/entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh
ENTRYPOINT ["/bin/entrypoint.sh"]
CMD [$ACTION]

