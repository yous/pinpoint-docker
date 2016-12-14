FROM debian:jessie
MAINTAINER Chayoung You <yousbe@gmail.com>

RUN echo 'deb http://httpredir.debian.org/debian/ jessie contrib' >> /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
  apt-utils \
  curl \
  fakeroot \
  git \
  java-package \
  libfontconfig1 \
  libgl1-mesa-glx \
  libgtk2.0-0 \
  libxslt1.1 \
  libxt6 \
  libxtst6 \
  libxxf86vm1 \
  net-tools \
  procps \
  wget

RUN useradd pinpoint -m
WORKDIR /home/pinpoint

RUN wget --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-x64.bin
RUN chown pinpoint jdk-6u45-linux-x64.bin
RUN su pinpoint -c 'yes | fakeroot make-jpkg jdk-6u45-linux-x64.bin'
RUN rm jdk-6u45-linux-x64.bin
RUN dpkg -i oracle-java6-jdk_6u45_amd64.deb
RUN rm oracle-java6-jdk_6u45_amd64.deb

RUN wget --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz
RUN chown pinpoint jdk-7u79-linux-x64.tar.gz
RUN su pinpoint -c 'yes | fakeroot make-jpkg jdk-7u79-linux-x64.tar.gz'
RUN rm jdk-7u79-linux-x64.tar.gz
RUN dpkg -i oracle-java7-jdk_7u79_amd64.deb
RUN rm oracle-java7-jdk_7u79_amd64.deb

ENV JAVA_6_HOME /usr/lib/jvm/jdk-6-oracle-x64
ENV JAVA_7_HOME /usr/lib/jvm/jdk-7-oracle-x64
ENV JAVA_HOME /usr/lib/jvm/jdk-7-oracle-x64

WORKDIR /usr/local/apache-maven

ADD http://mirror.apache-kr.org/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz ./
ADD http://www.apache.org/dist/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz.md5 ./
RUN [ $(md5sum apache-maven-3.2.5-bin.tar.gz | grep --only-matching -m 1 '^[0-9a-f]*') = $(cat apache-maven-3.2.5-bin.tar.gz.md5) ]
RUN tar -xf apache-maven-3.2.5-bin.tar.gz
ENV PATH $PATH:/usr/local/apache-maven/apache-maven-3.2.5/bin
RUN rm apache-maven-3.2.5-bin.tar.gz apache-maven-3.2.5-bin.tar.gz.md5

RUN git clone https://github.com/naver/pinpoint.git /pinpoint
WORKDIR /pinpoint
RUN git checkout tags/1.0.4
RUN mvn install -Dmaven.test.skip=true -B

WORKDIR quickstart/hbase
ADD http://archive.apache.org/dist/hbase/hbase-0.94.25/hbase-0.94.25.tar.gz ./
RUN tar -xf hbase-0.94.25.tar.gz
RUN rm hbase-0.94.25.tar.gz
RUN ln -s hbase-0.94.25 hbase
RUN cp ../conf/hbase/hbase-site.xml hbase-0.94.25/conf/
RUN chmod +x hbase-0.94.25/bin/start-hbase.sh

WORKDIR /pinpoint
VOLUME [/pinpoint]
