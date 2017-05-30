FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Patrick Ting - patrick@videoamp.com


# Install Java 8
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  apt-get update && \
  apt-get install -y apt-utils software-properties-common && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer


# Update existing packages
RUN \
  add-apt-repository universe && \
  apt-get update && \
  apt-get install -f && \
  apt-get dist-upgrade -y && \
  apt-get update && \
  apt-get install sudo -y


# Install Utils
RUN \
  apt-get install -y htop vim tcpdump


# Compile Dynomite
RUN \
  apt-get install -y git build-essential && \
  cd ~ && \
  git clone https://github.com/Netflix/dynomite.git && \
  cd dynomite && \
  apt-get install autoconf automake libtool libssl-dev -y && \
  #git checkout v0.5.8-6_FixHgetall && \
  git checkout v0.5.9-2_ProxyCloseFix && \
  autoreconf -fvi && \
  ./configure --enable-debug=log && \
  make && \
  make install


# Compile Dynomite Manager
RUN \
  cd ~ && \
  git clone https://github.com/VideoAmp/dynomite-manager.git && \
  cd dynomite-manager/ && \
  git checkout feature/ecs_support && \
  ./gradlew clean build -x test


# Setup Dynomite
RUN \
  useradd \
    --create-home \
    --system \
    --user-group \
    dynomite

COPY dynomite/conf/dynomite.yml /etc/dynomite/dynomite.yml
COPY dynomite/init.d/dynomite /etc/init.d/dynomite
RUN ssh-keygen -P '' -t rsa -f /etc/dynomite/dynomite.pem && \
  chown dynomite:dynomite /etc/dynomite/dynomite.pem

RUN chmod +x /etc/init.d/dynomite && update-rc.d dynomite defaults


# Setup Redis
RUN RUNLEVEL=1 apt-get install -y redis-server
COPY redis/conf/redis-server-etc-default.sh /etc/default/redis-server
COPY redis/conf/redis.conf /etc/redis/redis.dynomite.conf
COPY redis/init.d/redis-server /etc/init.d/redis-server
RUN \
  mv /etc/redis/redis.conf /etc/redis/redis.conf.orig && \
  ln -s redis.dynomite.conf /etc/redis/redis.conf && \
  chmod 755 /etc/init.d/redis-server && \
  rm /etc/systemd/system/redis.service


# Setup Dynomite Manager
COPY dynomite-manager/conf/membership.yml /etc/dynomite-manager/membership.yml
COPY dynomite-manager/conf/dynomite-manager-etc-default.sh /etc/default/dynomite-manager

# Setup log directories
RUN \
  mkdir -p /var/log/dynomite/ && \
  mkdir -p /var/log/dynomite-manager/ && \
  chown dynomite:dynomite /var/log/dynomite

# Setup Docker
# Expose the peer port
RUN echo 'Exposing peer port 8101'
EXPOSE 8101

# Expose the underlying Redis port
RUN echo 'Exposing Redis port 22122'
EXPOSE 22122

# Expose the stats/admin port
RUN echo 'Exposing stats/admin port 22222'
EXPOSE 22222

# Default port to acccess Dynomite
RUN echo 'Exposing client port for Dynomite 8102'
EXPOSE 8102


# Dynomite Manager Debug
RUN echo 'Exposing port for Dynomite Manager 8000'
EXPOSE 8000


# Dynomite Manager
RUN echo 'Exposing port for Dynomite Manager 8080'
EXPOSE 8080


# Setting overcommit for Redis to be able to do BGSAVE/BGREWRITEAOF
RUN sysctl vm.overcommit_memory=1

COPY docker/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Set the entry-point to be the startup script
ENTRYPOINT ["/entrypoint.sh"]