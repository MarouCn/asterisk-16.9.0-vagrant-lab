#!/bin/bash

apt-get update
apt-get -y install puppet

#Docker installation
apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Install needed packages for asterisk
apt-get -y install \
    g++ \
    libncurses5-dev \
    libncursesw5-dev \
    libxml2-dev \
    libsqlite3-dev \
    libsrtp-dev \
    uuid-dev \
    libedit-dev \
    build-essential \
    libssl-dev \
    python-dev \
    make


# Download asterisk 16.9.0
echo "Downloading asterisk 16.9.0 ..."
wget https://downloads.asterisk.org/pub/telephony/asterisk/old-releases/asterisk-16.9.0.tar.gz -O /usr/local/src/asterisk-16.9.0.tar.gz -nv
tar zxvf /usr/local/src/asterisk-16.9.0.tar.gz -C /usr/local/src

# Asterisk setup
echo "Running the asterisk configure script ..."
cd /usr/local/src/asterisk-16.9.0
./configure --with-jansson-bundled
echo "Compiling and installing asterisk ..."
make && make install
echo "Generating sample configs ..."
make samples
echo "Installing the asterisk startup script ..."
make config
echo "Copying pre-configured files for testing ..."
cp /vagrant/asterisk-config-files/* /etc/asterisk/
echo "Finished setup."



