FROM debian:stable-slim

# installation settings
ARG TL_MIRROR="https://texlive.info/CTAN/systems/texlive/tlnet"
ARG TL_YEAR="2024"

ADD ./runner runner

WORKDIR /runner

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["bash", "-c"]

RUN ./bin/installdependencies.sh && apt-get install -y perl jq curl fontconfig build-essential gnupg ghostscript python3-pygments && apt-get autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN mkdir "/tmp/texlive" && cd "/tmp/texlive" && \
    curl -O -L "$TL_MIRROR/install-tl-unx.tar.gz" && \
    tar xzvf ./install-tl-unx.tar.gz && \
    ( \
    echo "selected_scheme scheme-medium" && \
    echo "instopt_adjustpath 0" && \
    echo "tlpdbopt_install_docfiles 0" && \
    echo "tlpdbopt_install_srcfiles 0" && \
    echo "TEXDIR /opt/texlive/${TL_YEAR}" && \
    echo "TEXMFLOCAL /opt/texlive/texmf-local" && \
    echo "TEXMFSYSCONFIG /opt/texlive/${TL_YEAR}/texmf-config" && \
    echo "TEXMFSYSVAR /opt/texlive/${TL_YEAR}/texmf-var" && \
    echo "TEXMFHOME ~/.texmf" \
    ) > "/tmp/texlive.profile" && \
    "./install-tl-${TL_YEAR}"*"/install-tl" --location "$TL_MIRROR" -profile "/tmp/texlive.profile" && \
    rm -vf "/opt/texlive/${TL_YEAR}/install-tl" && \
    rm -vf "/opt/texlive/${TL_YEAR}/install-tl.log" && \
    rm -vrf /tmp/*

ENV PATH="${PATH}:/opt/texlive/${TL_YEAR}/bin/x86_64-linux"

RUN tlmgr install minted standalone forest courier automata algorithm2e pgf babel-italian microtype newpx xpatch fontaxes wrapfig enumitem filehook svn-prov import booktabs multirow koma-script caption fancyvrb upquote ifoddpage relsize csquotes ulem hvpygmentex epstopdf newpx newtx

ADD --chmod=754 ./start-org.sh start.sh

ENV RUNNER_MANAGER_TOKEN=""
ENV GITHUB_ORG=""
ENV RUNNER_NAME=""
ENV ACTIONS_RUNNER_INPUT_REPLACE=true
ENV RUNNER_ALLOW_RUNASROOT=true

ENTRYPOINT ["bash", "-c", "./start.sh"]
