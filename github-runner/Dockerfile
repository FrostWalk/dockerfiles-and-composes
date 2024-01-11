FROM debian:stable-slim

ADD ./runner runner

WORKDIR /runner

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["bash", "-c"]

RUN ./bin/installdependencies.sh && apt-get install -y jq curl git \
    && apt-get autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/

ADD --chmod=754 ./start-org.sh start.sh

ENV RUNNER_MANAGER_TOKEN=""
ENV GITHUB_ORG=""
ENV RUNNER_NAME=""
ENV ACTIONS_RUNNER_INPUT_REPLACE=true
ENV RUNNER_ALLOW_RUNASROOT=true

ENTRYPOINT ["bash", "-c", "./start.sh"]
