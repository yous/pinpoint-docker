# Pinpoint Docker

Docker for [Pinpoint](https://github.com/naver/pinpoint). You can see the repository on [yous/pinpoint](https://registry.hub.docker.com/u/yous/pinpoint/).

## About

This Docker runs on Debian (wheezy). Minimal requirements are installed:

- `git`, `wget`, `curl`, `ps`, `netstat`
- Oracle Java SE 6 and 7
- Maven 3.2.5
- Pinpoint
- HBase 0.94.25

## Installation

``` sh
docker pull yous/pinpoint
```

## Usage

``` sh
docker run -i -t --rm yous/pinpoint bash
```

## Starting

### Start HBase

- Start: `quickstart/bin/start-hbase.sh`
- Initialize Tables: `quickstart/bin/init-hbase.sh`

### Start Pinpoint Daemons

- Collector: `quickstart/bin/start-collector.sh`
- Web UI: `quickstart/bin/start-web.sh`
- TestApp: `quickstart/bin/start-testapp.sh`

Visit the following addresses to test out your Pinpoint instance.

- Web UI: `http://localhost:28080`
- TestApp: `http://localhost:28081`

## Stopping

- HBase: `quickstart/bin/stop-hbase.sh`
- Collector: `quickstart/bin/stop-collector.sh`
- Web UI: `quickstart/bin/stop-web.sh`
- TestApp: `quickstart/bin/stop-testapp.sh`

## License

Copyright (c) ChaYoung You. See [LICENSE.txt](https://github.com/yous/pinpoint-docker/blob/master/LICENSE.txt) for details.
