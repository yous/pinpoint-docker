# Pinpoint Docker

Docker for [Pinpoint](https://github.com/naver/pinpoint). You can see the
repository on [yous/pinpoint](https://registry.hub.docker.com/u/yous/pinpoint/).

## About

This Docker runs on Debian (wheezy). Minimal requirements are installed:

- `git`, `wget`, `curl`, `ps`, `netstat`
- Oracle Java SE 6 and 7
- Maven 3.2.5
- Pinpoint 1.0.5
- HBase 0.94.25

For more information about this Dockerfile, see
["Using Pinpoint with Docker"](http://yous.be/2015/05/05/using-pinpoint-with-docker/).

## Installation

If you want to use latest Pinpoint,

``` sh
docker pull yous/pinpoint
```

Also you can specify the version `1.0.4`:

``` sh
docker pull yous/pinpoint:1.0.4
```

## Usage

``` sh
docker run -i -t --rm yous/pinpoint:1.0.5 bash
```

## Quickstart

``` sh
docker run -it --rm -p 28080:28080 -p 28081:28081 -p 28082:28082 \
--cap-add SYS_PTRACE --security-opt apparmor:unconfined yous/pinpoint:1.0.5 bash
```

We have to expose some ports used by Pinpoint by specifying `-p` options.
`--cap-add SYS_PTRACE --security-opt apparmor:unconfined` is needed for
`netstat -anp` for displaying its PID with the program name. See
[docker/docker#7276](https://github.com/docker/docker/issues/7276) for details.

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

Copyright (c) Chayoung You. See
[LICENSE.txt](https://github.com/yous/pinpoint-docker/blob/master/LICENSE.txt)
for details.
