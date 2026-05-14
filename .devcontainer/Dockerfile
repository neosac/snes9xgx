FROM ghcr.io/extremscorner/libogc2:latest

ARG DEVKITPRO=/opt/devkitpro
ARG DEVKITPPC=${DEVKITPRO}/devkitPPC
ARG PORTLIBS=${DEVKITPRO}/portlibs/ppc

ENV DEVKITPRO=${DEVKITPRO}
ENV DEVKITPPC=${DEVKITPPC}
ENV PORTLIBS=${PORTLIBS}
ENV PATH=${DEVKITPPC}/bin:${PATH}

# Install convenience tools for development
RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    pkg-config \
    unzip \
    zip \
    sudo \
    nano \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Verify base image provides the expected devkitPPC/libogc2 toolchain
RUN powerpc-eabi-gcc --version && \
    test -f ${DEVKITPPC}/bin/powerpc-eabi-gcc 
    #&& \
#    test -f ${DEVKITPRO}/libogc2/lib/libogc.a

WORKDIR /workspaces/snes9xgx
CMD ["/bin/bash"]
