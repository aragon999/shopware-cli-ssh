ARG PHP_VERSION=php74

FROM shyim/shopware-cli:${PHP_VERSION} as BASE

USER root

RUN \
    apk add --no-cache sudo openssh && \
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config && \
    echo "dev ALL=(ALL) NOPASSWD: /usr/sbin/sshd -D, /usr/bin/ssh-keygen, /bin/mkdir -p /var/run/sshd, /usr/sbin/usermod -p * dev" >> /etc/sudoers

ADD docker-entrypoint.sh /usr/local/bin

USER dev
RUN echo "alias ll=\"ls -lha\"" >> ~/.bashrc

EXPOSE 22
ENTRYPOINT ["docker-entrypoint.sh"]
