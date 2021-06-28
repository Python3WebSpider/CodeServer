FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    openssl \
    net-tools \
    git \
    zsh \
    locales \
    sudo \
    dumb-init \
    vim \
    curl \
    wget \
    bash-completion \
    python3 \
    python3-pip \
    python3-setuptools \
    build-essential \
    python3-dev \
    libssl-dev \
    libffi-dev \
    libxml2 \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev

RUN chsh -s /bin/bash
ENV SHELL=/bin/bash

RUN ARCH=amd64 && \
    curl -sSL "https://github.com/boxboat/fixuid/releases/download/v0.4.1/fixuid-0.4.1-linux-$ARCH.tar.gz" | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: coder\ngroup: coder\n" > /etc/fixuid/config.yml

RUN CODE_SERVER_VERSION=3.10.2 && \
    curl -sSOL https://github.com/cdr/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_amd64.deb && \
    sudo dpkg -i code-server_${CODE_SERVER_VERSION}_amd64.deb

RUN locale-gen en_US.UTF-8

ENV LC_ALL=en_US.UTF-8

RUN adduser --disabled-password --gecos '' coder && \
    adduser coder sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers;

RUN chmod g+rw /home && \
    mkdir -p /home/coder/workspace && \
    mkdir -p /home/coder/.local && \
    chown -R coder:coder /home/coder && \
    chown -R coder:coder /home/coder/.local && \
    chown -R coder:coder /home/coder/workspace;

USER coder

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
        ~/.fzf/install

ENV PASSWORD=${PASSWORD:-P@ssw0rd}

COPY ./extensions /home/coder/.local/extensions

RUN /usr/bin/code-server --install-extension ms-python.python && \
    /usr/bin/code-server --install-extension esbenp.prettier-vscode && \
    /usr/bin/code-server --install-extension equinusocio.vsc-material-theme && \
    /usr/bin/code-server --install-extension codezombiech.gitignore && \
    /usr/bin/code-server --install-extension piotrpalarz.vscode-gitignore-generator && \
    /usr/bin/code-server --install-extension aeschli.vscode-css-formatter && \
    /usr/bin/code-server --install-extension donjayamanne.githistory && \
    /usr/bin/code-server --install-extension ecmel.vscode-html-css && \
    /usr/bin/code-server --install-extension pkief.material-icon-theme && \
    /usr/bin/code-server --install-extension equinusocio.vsc-material-theme-icons && \
    /usr/bin/code-server --install-extension eg2.vscode-npm-script && \
    /usr/bin/code-server --install-extension ms-ceintl.vscode-language-pack-zh-hans && \
    /usr/bin/code-server --install-extension /home/coder/.local/extensions/tkrkt.linenote-1.2.1.vsix && \
    /usr/bin/code-server --install-extension dbaeumer.vscode-eslint

RUN /usr/bin/python3 -m pip install -U pip setuptools

RUN /usr/bin/python3 -m pip install requests httpx scrapy aiohttp pyquery beautifulsoup4 \
  selenium pyppeteer pylint flask django tornado numpy pandas scipy autopep8

COPY settings.json /home/coder/.local/share/code-server/User/settings.json

RUN sudo chown coder /home/coder/.local/share/code-server/User/settings.json

COPY entrypoint.sh /home/coder/.local/entrypoint.sh

RUN sudo chmod +x /home/coder/.local/entrypoint.sh

WORKDIR /home/coder/workspace

EXPOSE 8080

ENTRYPOINT ["/bin/sh", "/home/coder/.local/entrypoint.sh"]
