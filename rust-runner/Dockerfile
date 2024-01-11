FROM rust:slim

ADD --chmod=754 autover /bin/

ADD ./runner runner

WORKDIR /runner

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["bash", "-c"]

RUN ./bin/installdependencies.sh

RUN apt-get install -y libssl-dev pkg-config python3 python3-virtualenv python3-pip curl git jq expat uuid-dev libffi-dev \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli.gpg \
    && echo "deb [arch=arm64 signed-by=/usr/share/keyrings/githubcli.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update && apt-get install gh -y && apt-get autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/ /etc/apt-get/sources.list.d/github-cli.list usr/share/keyrings/githubcli.gpg

RUN rustup self update && rustup install nightly && rustup override set stable \
    && rustup update && rustup component add rustfmt && rustup component add clippy \
    && cargo install cargo-readme cargo2junit cargo-update

COPY --chmod=755 ./python python

RUN python3 -m virtualenv venv && source venv/bin/activate && pip install --upgrade --force --no-cache-dir -r ./python/requirements.txt

ADD --chmod=754 ./start-org.sh start.sh

ENV RUNNER_MANAGER_TOKEN=""
ENV GITHUB_ORG=""
ENV RUNNER_NAME=""
ENV ACTIONS_RUNNER_INPUT_REPLACE=true
ENV RUNNER_ALLOW_RUNASROOT=true

ENTRYPOINT ["./start.sh"]
