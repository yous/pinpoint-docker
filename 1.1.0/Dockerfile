FROM debian:jessie
MAINTAINER Chayoung You <yousbe@gmail.com>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  apt-utils \
  curl \
  git \
  net-tools \
  procps \
  software-properties-common \
  wget

RUN add-apt-repository "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main"
RUN echo oracle-java6-installer shared/accepted-oracle-license-v1-1 select true | \
  debconf-set-selections
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | \
  debconf-set-selections

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  oracle-java6-installer=6u45-0~webupd8~8 \
  oracle-java7-installer=7u80+7u60arm-0~webupd8~1

ENV JAVA_6_HOME /usr/lib/jvm/java-6-oracle
ENV JAVA_7_HOME /usr/lib/jvm/java-7-oracle
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

RUN useradd pinpoint -m

WORKDIR /usr/local/apache-maven
ADD https://archive.apache.org/dist/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz ./
ADD https://archive.apache.org/dist/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz.sha1 ./
RUN [ $(sha1sum apache-maven-3.2.5-bin.tar.gz | grep --only-matching -m 1 '^[0-9a-f]*') = $(cat apache-maven-3.2.5-bin.tar.gz.sha1) ]
RUN tar -xf apache-maven-3.2.5-bin.tar.gz
ENV PATH $PATH:/usr/local/apache-maven/apache-maven-3.2.5/bin
RUN rm apache-maven-3.2.5-bin.tar.gz apache-maven-3.2.5-bin.tar.gz.sha1

RUN git clone https://github.com/naver/pinpoint.git /pinpoint
WORKDIR /pinpoint
RUN git checkout tags/1.1.0
RUN mvn install -Dmaven.test.skip=true -B

WORKDIR quickstart/hbase
ADD https://archive.apache.org/dist/hbase/hbase-1.0.1/hbase-1.0.1-bin.tar.gz ./
RUN tar -xf hbase-1.0.1-bin.tar.gz
RUN rm hbase-1.0.1-bin.tar.gz
RUN ln -s hbase-1.0.1 hbase
RUN cp ../conf/hbase/hbase-site.xml hbase-1.0.1/conf/

WORKDIR /pinpoint
VOLUME [/pinpoint]
