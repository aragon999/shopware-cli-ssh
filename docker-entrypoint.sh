#!/bin/sh

if [ ! -f "/etc/ssh/ssh_host_rsa_key" ]; then
    # generate fresh rsa key
    sudo ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
fi
if [ ! -f "/etc/ssh/ssh_host_dsa_key" ]; then
    # generate fresh dsa key
    sudo ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
fi

#prepare run dir
if [ ! -d "/var/run/sshd" ]; then
    sudo mkdir -p /var/run/sshd
fi

if [ "${SSH_PASSWORD}" != "" ]; then
    sudo usermod -p $(openssl passwd -1 ${SSH_PASSWORD}) dev
fi

sudo /usr/sbin/sshd -D &

exec "$@"
