FROM debian
MAINTAINER ChaYoung You <yousbe@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN echo 'deb http://http.debian.net/debian/ wheezy contrib' >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y git wget curl procps net-tools
RUN apt-get install -y java-package fakeroot

RUN useradd pinpoint -m
WORKDIR /home/pinpoint

RUN wget --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-x64.bin
RUN chown pinpoint jdk-6u45-linux-x64.bin
RUN su pinpoint -c 'yes | fakeroot make-jpkg jdk-6u45-linux-x64.bin'
RUN rm jdk-6u45-linux-x64.bin
RUN dpkg -i oracle-j2sdk1.6_1.6.0+update45_amd64.deb
RUN rm oracle-j2sdk1.6_1.6.0+update45_amd64.deb

RUN wget --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz
RUN chown pinpoint jdk-7u79-linux-x64.tar.gz
RUN su pinpoint -c 'yes | fakeroot make-jpkg jdk-7u79-linux-x64.tar.gz'
RUN rm jdk-7u79-linux-x64.tar.gz
RUN dpkg -i oracle-j2sdk1.7_1.7.0+update79_amd64.deb
RUN rm oracle-j2sdk1.7_1.7.0+update79_amd64.deb

ENV JAVA_6_HOME /usr/lib/jvm/j2sdk1.6-oracle
ENV JAVA_7_HOME /usr/lib/jvm/j2sdk1.7-oracle
ENV JAVA_HOME /usr/lib/jvm/j2sdk1.7-oracle

WORKDIR /usr/local/apache-maven

ADD http://mirror.apache-kr.org/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz ./
ADD http://www.apache.org/dist//maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz.md5 ./
ADD http://www.apache.org/dist//maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz.asc ./
RUN [ $(md5sum apache-maven-3.2.5-bin.tar.gz | grep --only-matching -m 1 '^[0-9a-f]*') = $(cat apache-maven-3.2.5-bin.tar.gz.md5) ]
RUN gpg --keyserver pgp.mit.edu --recv-key BB617866
RUN gpg --verify apache-maven-3.2.5-bin.tar.gz.asc apache-maven-3.2.5-bin.tar.gz
RUN tar -zxf apache-maven-3.2.5-bin.tar.gz
ENV PATH $PATH:/usr/local/apache-maven/apache-maven-3.2.5/bin
RUN rm apache-maven-3.2.5-bin.tar.gz apache-maven-3.2.5-bin.tar.gz.md5 apache-maven-3.2.5-bin.tar.gz.asc

RUN git clone https://github.com/naver/pinpoint.git /pinpoint
WORKDIR /pinpoint
RUN mvn install -Dmaven.test.skip=true

WORKDIR quickstart/hbase
ADD http://archive.apache.org/dist/hbase/hbase-0.94.25/hbase-0.94.25.tar.gz ./
RUN tar -zxf hbase-0.94.25.tar.gz
RUN rm hbase-0.94.25.tar.gz
RUN ln -s hbase-0.94.25 hbase
RUN cp ../conf/hbase/hbase-site.xml hbase-0.94.25/conf/
RUN chmod +x hbase-0.94.25/bin/start-hbase.sh

WORKDIR /pinpoint
VOLUME [/pinpoint]
