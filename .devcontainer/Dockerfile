FROM ubuntu:22.04

ARG DEVKITPRO=/opt/devkitpro
ARG DEVKITPPC=${DEVKITPRO}/devkitPPC
ARG PORTLIBS=${DEVKITPRO}/portlibs/ppc

ENV DEVKITPRO=${DEVKITPRO}
ENV DEVKITPPC=${DEVKITPPC}
ENV PORTLIBS=${PORTLIBS}
ENV PATH=${DEVKITPPC}/bin:${PATH}

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    curl \
    pkg-config \
    libpng-dev \
    libfreetype6-dev \
    texinfo \
    bison \
    flex \
    automake \
    libtool \
    ca-certificates \
    unzip \
    zip \
    sudo \
    nano \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Create devkitpro directory
RUN mkdir -p ${DEVKITPRO}

# Download and extract devkitPPC
RUN cd /tmp && \
    wget -q https://github.com/devkitPro/devkitppc/releases/download/v13.1.0/devkitPPC_r38-x86_64-linux.tar.bz2 && \
    tar xjf devkitPPC_r38-x86_64-linux.tar.bz2 -C ${DEVKITPRO} && \
    rm devkitPPC_r38-x86_64-linux.tar.bz2

# Download and extract libogc2
RUN cd /tmp && \
    wget -q https://github.com/devkitPro/libogc2/releases/download/v2.4.2/libogc2-2.4.2.tar.bz2 && \
    tar xjf libogc2-2.4.2.tar.bz2 -C ${DEVKITPRO} && \
    rm libogc2-2.4.2.tar.bz2

# Create portlibs directory structure
RUN mkdir -p ${PORTLIBS}/{include,lib}

# Download and extract portlibs_ppc (contains precompiled libraries)
RUN cd /tmp && \
    wget -q https://github.com/devkitPro/portlibs_ppc/releases/download/v2.1.0/portlibs_ppc-2.1.0.tar.bz2 && \
    tar xjf portlibs_ppc-2.1.0.tar.bz2 -C ${DEVKITPRO} && \
    rm portlibs_ppc-2.1.0.tar.bz2

# Verify installation
RUN powerpc-eabi-gcc --version && \
    test -f ${DEVKITPPC}/bin/powerpc-eabi-gcc && \
    test -f ${DEVKITPRO}/libogc2/lib/libogc.a

WORKDIR /workspaces/snes9xgx
CMD ["/bin/bash"]
