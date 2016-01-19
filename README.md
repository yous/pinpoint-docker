# Pinpoint Docker

[![Docker Stars](https://img.shields.io/docker/stars/yous/pinpoint.svg)](https://hub.docker.com/r/yous/pinpoint/)

Docker for [Pinpoint](https://github.com/naver/pinpoint). You can see the repository on [yous/pinpoint](https://registry.hub.docker.com/u/yous/pinpoint/).

## About

All versions of Docker run on Debian (jessie). Minimal requirements are installed, `git`, `wget`, `curl`, `ps`, `netstat`.

### 1.5.0

- Oracle Java SE 6 and 8 with `JAVA_6_HOME`, `JAVA_7_HOME`, `JAVA_8_HOME` and `JAVA_HOME`
- Maven 3.2.5
- HBase 1.0.1

### 1.1.2

- Oracle Java SE 6 and 7 with `JAVA_6_HOME`, `JAVA_7_HOME` and `JAVA_HOME`
- Maven 3.2.5
- HBase 1.0.1

### 1.1.1

- Oracle Java SE 6 and 7 with `JAVA_6_HOME`, `JAVA_7_HOME` and `JAVA_HOME`
- Maven 3.2.5
- HBase 1.0.1

### 1.1.0

- Oracle Java SE 6 and 7 with `JAVA_6_HOME`, `JAVA_7_HOME` and `JAVA_HOME`
- Maven 3.2.5
- HBase 1.0.1

### 1.0.5

- Oracle Java SE 6 and 7 with `JAVA_6_HOME`, `JAVA_7_HOME` and `JAVA_HOME`
- Maven 3.2.5
- HBase 0.94.25

### 1.0.4

- Oracle Java SE 6 and 7 with `JAVA_6_HOME`, `JAVA_7_HOME` and `JAVA_HOME`
- Maven 3.2.5
- HBase 0.94.25

For more information about this Dockerfile, see ["Using Pinpoint with Docker"](http://yous.be/2015/05/05/using-pinpoint-with-docker/).

## Installation

If you want to use latest version of Pinpoint supported by the Dockerfile,

``` sh
docker pull yous/pinpoint
```

Also you can specify the version:

``` sh
docker pull yous/pinpoint:1.0.4
```

See [tags](https://hub.docker.com/r/yous/pinpoint/tags/) for the list of all available versions.

## Usage

``` sh
docker run -i -t yous/pinpoint:1.5.0 bash
```

## Quickstart

``` sh
docker run -i -t -p 28080-28082:28080-28082 --cap-add SYS_PTRACE \
yous/pinpoint:1.5.0 bash
```

We have to expose some ports used by Pinpoint by specifying `-p` options. `--cap-add SYS_PTRACE` is needed for `netstat -anp` for displaying its PID with the program name. See [docker/docker#7276](https://github.com/docker/docker/issues/7276) for details.

### Starting

#### Start HBase

- Start: `quickstart/bin/start-hbase.sh`
- Initialize Tables: `quickstart/bin/init-hbase.sh`

#### Start Pinpoint Daemons

- Collector: `quickstart/bin/start-collector.sh`
- Web UI: `quickstart/bin/start-web.sh`
- TestApp: `quickstart/bin/start-testapp.sh`

Visit the following addresses to test out your Pinpoint instance.

- Web UI: `http://localhost:28080`
- TestApp: `http://localhost:28081`

### Stopping

- HBase: `quickstart/bin/stop-hbase.sh`
- Collector: `quickstart/bin/stop-collector.sh`
- Web UI: `quickstart/bin/stop-web.sh`
- TestApp: `quickstart/bin/stop-testapp.sh`

## License

Copyright © Chayoung You. See [LICENSE.txt](https://github.com/yous/pinpoint-docker/blob/master/LICENSE.txt) for details.
