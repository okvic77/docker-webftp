FROM ubuntu:14.04
MAINTAINER Victor Rojas

RUN export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install curl -y && \
  curl -sL https://deb.nodesource.com/setup_5.x | bash - && \
  apt-get install -y openssh-server supervisor vsftpd nodejs build-essential -y

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD vsftpd.conf /etc/

RUN mkdir -p /var/run/sshd /var/log/supervisor && \
  mkdir -p /var/run/vsftpd/empty && \
  chown root:root /etc/vsftpd.conf

RUN adduser --disabled-password --gecos '' user
RUN echo 'user:password' | chpasswd

ADD app /app
RUN cd /app && npm install

VOLUME ['/home']

EXPOSE 21/tcp 80
CMD ["/usr/bin/supervisord"]
