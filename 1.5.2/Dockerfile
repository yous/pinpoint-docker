FROM debian:jessie
MAINTAINER Chayoung You <yousbe@gmail.com>

RUN echo 'deb http://httpredir.debian.org/debian/ jessie contrib' >> /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git wget curl procps net-tools apt-utils
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y java-package fakeroot
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libgl1-mesa-glx libfontconfig1 libxslt1.1 libxtst6 libxxf86vm1 libgtk2.0-0 libxt6

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

RUN wget --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  http://download.oracle.com/otn-pub/java/jdk/8u112-b15/jdk-8u112-linux-x64.tar.gz
RUN chown pinpoint jdk-8u112-linux-x64.tar.gz
RUN su pinpoint -c 'yes | fakeroot make-jpkg jdk-8u112-linux-x64.tar.gz'
RUN rm jdk-8u112-linux-x64.tar.gz
RUN dpkg -i oracle-java8-jdk_8u112_amd64.deb
RUN rm oracle-java8-jdk_8u112_amd64.deb

ENV JAVA_6_HOME /usr/lib/jvm/jdk-6-oracle-x64
ENV JAVA_7_HOME /usr/lib/jvm/jdk-7-oracle-x64
ENV JAVA_8_HOME /usr/lib/jvm/jdk-8-oracle-x64
ENV JAVA_HOME /usr/lib/jvm/jdk-8-oracle-x64

WORKDIR /usr/local/apache-maven

ADD http://mirror.apache-kr.org/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz ./
ADD http://www.apache.org/dist/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz.md5 ./
ADD http://www.apache.org/dist/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz.asc ./
RUN [ $(md5sum apache-maven-3.2.5-bin.tar.gz | grep --only-matching -m 1 '^[0-9a-f]*') = $(cat apache-maven-3.2.5-bin.tar.gz.md5) ]
RUN gpg --keyserver pgp.mit.edu --recv-key BB617866
RUN gpg --verify apache-maven-3.2.5-bin.tar.gz.asc apache-maven-3.2.5-bin.tar.gz
RUN tar -xf apache-maven-3.2.5-bin.tar.gz
ENV PATH $PATH:/usr/local/apache-maven/apache-maven-3.2.5/bin
RUN rm apache-maven-3.2.5-bin.tar.gz apache-maven-3.2.5-bin.tar.gz.md5 apache-maven-3.2.5-bin.tar.gz.asc

RUN git clone https://github.com/naver/pinpoint.git /pinpoint
WORKDIR /pinpoint
RUN git checkout tags/1.5.2
RUN mvn install -Dmaven.test.skip=true -B

WORKDIR quickstart/hbase
ADD http://archive.apache.org/dist/hbase/hbase-1.0.3/hbase-1.0.3-bin.tar.gz ./
RUN tar -xf hbase-1.0.3-bin.tar.gz
RUN rm hbase-1.0.3-bin.tar.gz
RUN ln -s hbase-1.0.3 hbase
RUN cp ../conf/hbase/hbase-site.xml hbase-1.0.3/conf/
RUN chmod +x hbase-1.0.3/bin/start-hbase.sh

WORKDIR /pinpoint
VOLUME [/pinpoint]
