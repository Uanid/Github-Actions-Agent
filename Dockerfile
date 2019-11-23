FROM ubuntu:bionic
MAINTAINER uanid@outlook.com

ENV AGENT_ALLOW_RUNASROOT true

RUN apt-get -q -y update \
 && apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install curl git \
 && rm /etc/dpkg/dpkg.cfg.d/excludes \
 && apt-get -q -y autoremove \
 && apt-get -q -y clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/actions-agent/
RUN mkdir actions-runner && cd actions-runner
RUN curl -O https://githubassets.azureedge.net/runners/2.160.2/actions-runner-linux-x64-2.160.2.tar.gz
RUN tar xzf ./actions-runner-linux-x64-2.160.2.tar.gz
RUN rm -f ./actions-runner-linux-x64-2.160.2.tar.gz

RUN ./bin/installdependencies.sh

COPY entrypoint.sh entrypoint.sh
RUN chmod 777 entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
