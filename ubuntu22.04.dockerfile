FROM ubuntu:22.04

# Update system and install required packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade -y && \
    apt install -y gawk wget git-core diffstat unzip texinfo \
    gcc-multilib build-essential chrpath socat file cpio python3 \
    python3-pip python3-pexpect xz-utils debianutils iputils-ping \
    libsdl1.2-dev xterm tar locales net-tools rsync sudo vim curl zstd \
    liblz4-tool libssl-dev bc lzop libgnutls28-dev efitools git-lfs \
    keychain pipx make ninja-build tmux xclip xsel iproute2 \
    bridge-utils iptables expect

# Install Neovim
COPY neovim-installer.sh /neovim-installer.sh
RUN chmod +x /neovim-installer.sh && \
    /neovim-installer.sh && \
    rm -f /neovim-installer.sh

# Set up locales
RUN locale-gen en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Ensure /bin/sh points to bash (Yocto requires this)
RUN ln -sf bash /bin/sh

# Install repo
ADD https://storage.googleapis.com/git-repo-downloads/repo /usr/local/bin/repo
RUN chmod 755 /usr/local/bin/repo

ARG USER
# Create the user with a home directory and set Bash as the default shell
RUN useradd -m -s /bin/bash ${USER} && \
    echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER} && \
    chmod 0440 /etc/sudoers.d/${USER}


# Ensure user has the correct UID/GID for volume-mounted builds
ARG USER
RUN usermod -u $(id -u ${USER}) -g $(id -g ${USER}) ${USER}

# Set working directory
ARG DOCKER_WORKDIR
WORKDIR ${DOCKER_WORKDIR}

# Switch to the Yocto user
USER ${USER}
