# Author : Jay Lee
# E-mail : jaewon.lee@hyundai-autron.com
# This script only works in Linux Host OS

FROM ubuntu:18.04

RUN sed -i 's/archive.ubuntu.com/ftp.daum.net/g' /etc/apt/sources.list 

RUN yoctoDeps=' \
      build-essential \
      chrpath \
      diffstat \
      gawk \
      gcc-multilib \
      git \
      language-pack-en-base \
      libsdl1.2-dev \
      locales \
      socat \
      texinfo \
      unzip \
      wget \
      xterm \
      repo \
      parted \
      dosfstools \
      mtools \
    ' \
    mobilgeneDeps=' \
      sudo \
      apt-utils \
      xz-utils \
      build-essential \
      curl \
      less \
      wget \
      cmake \
      python \
      python-lxml \
      python3-pip \
      net-tools \
      iproute2 \
      iputils-ping \
      gdb \
      gdbserver \
      libjansson-dev \
      doxygen \
      graphviz \
      libpcap-dev \
      libsnmp-dev \
      cmake-curses-gui \
      cmake-gui \
      tftp-hpa  \
    ' \
    nxpDeps=' \
      binutils-aarch64-linux-gnu cpio cpp-7-aarch64-linux-gnu cpp-aarch64-linux-gnu \
      gcc-7-aarch64-linux-gnu-base gcc-7-cross-base gcc-8-cross-base \
      libasan4-arm64-cross libatomic1-arm64-cross libc6-arm64-cross libc6-dev-arm64-cross \
      libgcc-7-dev-arm64-cross libgcc1-arm64-cross libgomp1-arm64-cross libgpm2 libitm1-arm64-cross liblsan0-arm64-cross \
      libncurses5-dev libstdc++-7-dev-arm64-cross libstdc++6-arm64-cross libstring-crc32-perl libtsan0-arm64-cross \
      libubsan0-arm64-cross linux-libc-dev-arm64-cross python3-pexpect python3-ptyprocess screen tofrodos vim vim-common \
      vim-runtime xxd \
    ' \
    otherDeps=' \
      libboost-all-dev \
      iptables \
      debianutils \
    ' \
    && apt-get update && apt-get install -y \
      $yoctoDeps \
      $mobilgeneDeps \
      $otherDeps \
      $nxpDeps
  
RUN pip3 install lxml jinja2 treelib

#install clang 6.0
RUN apt-get update && apt-get install -y software-properties-common
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add -
RUN add-apt-repository "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-6.0 main" && apt-get update
RUN apt-get update && apt-get install -y clang-6.0 lldb-6.0 lld-6.0

#create mount points and set owner
RUN mkdir /adar
RUN mkdir /adar/projects
RUN mkdir /adar/fsl-auto-yocto-bsp
RUN mkdir /adar/scripts
RUN mkdir /adar/meta-mobilgene
RUN mkdir /adar/downloads
RUN mkdir /adar/sstate-cache

ENV LD_LIBRARY_PATH "/adar/install/lib:/usr/lib"

CMD [ "/bin/bash" ]
