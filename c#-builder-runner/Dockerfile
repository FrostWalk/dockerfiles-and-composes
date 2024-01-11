FROM debian:stable-slim

ADD ./runner runner

WORKDIR /runner

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["bash", "-c"]

RUN ./bin/installdependencies.sh

RUN apt-get install --no-install-recommends -y curl wget xz-utils git jq ca-certificates gnupg python3 libatomic1 && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key |  gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && apt-get update && apt-get -y install nodejs \
    && wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh \
    && chmod +x dotnet-install.sh && bash dotnet-install.sh --version latest \
    && apt-get -y purge wget && apt-get autoclean && apt-get autoremove -y \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ dotnet-install.sh /etc/apt/sources.list.d/nodesource.list /etc/apt/keyrings/nodesource.gpg \
    && curl -fsSL https://get.pnpm.io/install.sh | bash -

ENV PATH=$PATH:/root/.dotnet:/root/.dotnet/tools

ADD --chmod=754 ./start-org.sh start.sh

ENV RUNNER_MANAGER_TOKEN=""
ENV GITHUB_ORG=""
ENV RUNNER_NAME=""
ENV ACTIONS_RUNNER_INPUT_REPLACE=true
ENV RUNNER_ALLOW_RUNASROOT=true

ENTRYPOINT ["./start.sh"]
