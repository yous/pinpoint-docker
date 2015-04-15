FROM debian
MAINTAINER ChaYoung You <yousbe@gmail.com>

RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y openjdk-6-jdk openjdk-7-jdk

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

VOLUME [/pinpoint]
