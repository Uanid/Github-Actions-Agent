FROM ubuntu:bionic
MAINTAINER uanid@outlook.com

ENV AGENT_ALLOW_RUNASROOT true

RUN apt-get -y update \
 && apt-get -y install curl git apt-transport-https ca-certificates gnupg-agent software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get install -y docker-ce docker-ce-cli containerd.io

WORKDIR /usr/local/actions-agent/
RUN mkdir actions-runner && cd actions-runner
RUN curl -O https://githubassets.azureedge.net/runners/2.160.2/actions-runner-linux-x64-2.160.2.tar.gz
RUN tar xzf ./actions-runner-linux-x64-2.160.2.tar.gz
RUN rm -f ./actions-runner-linux-x64-2.160.2.tar.gz

RUN ./bin/installdependencies.sh

COPY entrypoint.sh entrypoint.sh
RUN chmod 777 entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
