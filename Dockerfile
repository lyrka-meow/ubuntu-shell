FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ARG FASTFETCH_VERSION=2.66.0
ARG FASTFETCH_SHA256=c4aa1de46874524cdc492795d937772281409fa86aea377cae6832d9e70218cb

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash-completion \
        ca-certificates \
        curl \
        git \
        less \
        nano \
        sudo \
        vim-tiny \
    && rm -rf /var/lib/apt/lists/* \
    && (id -u ubuntu >/dev/null 2>&1 || useradd --create-home --shell /bin/bash ubuntu) \
    && echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu \
    && chmod 0440 /etc/sudoers.d/ubuntu \
    && curl -fsSL \
        "https://github.com/fastfetch-cli/fastfetch/releases/download/${FASTFETCH_VERSION}/fastfetch-linux-amd64.deb" \
        -o /tmp/fastfetch.deb \
    && echo "${FASTFETCH_SHA256}  /tmp/fastfetch.deb" | sha256sum --check \
    && apt-get install -y /tmp/fastfetch.deb \
    && rm /tmp/fastfetch.deb

USER ubuntu
WORKDIR /home/ubuntu

CMD ["sleep", "infinity"]
