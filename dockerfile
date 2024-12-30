# Start from multi-architecture base image
FROM --platform=$BUILDPLATFORM ubuntu:latest AS base

# Set environment variables
ENV QEMU_VERSION=v7.2.0-1 
ENV PATH="/root/.cargo/bin:${PATH}"

# Install required packages (TO BE FILTERED LATER)
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    qemu-system \
    qemu-user-static \
    binfmt-support \
    software-properties-common \
    python3 \
    python3-pip \
    curl \
    sudo \
    gdb \
    && apt-get clean

# Install QEMU and configure for x64 (DO NOT TOUCH)
RUN mkdir -p /usr/qemu-x64 \
    && curl -L https://github.com/multiarch/qemu-user-static/releases/download/${QEMU_VERSION}/qemu-x86_64-static.tar.gz | tar xz -C /usr/qemu-x64 \
    && ln -sf /usr/qemu-x64/qemu-x86_64-static /usr/bin/qemu-x86_64-static

# Install Rust (DO NOT TOUCH)
RUN apt-get update && apt-get install -y curl
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Copy project files into the container
COPY . /app

# Set the working directory to the project
WORKDIR /app

# Run unit and integration tests (LAUNCHING TESTS AUTOMATICALLY)
# NB: MUST HAVE IMAGES DB INCLUDED IN ORDER TO PASS INTEGRATION TESTS
CMD ["cargo", "test", "--release"]
