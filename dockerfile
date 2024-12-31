# Start from aarch64 and x86_64 architectures compatible base image
FROM nginx

# Install required packages (FILTERED)
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl \
    cargo \
    sudo \
    gdb \
    && apt-get clean

# Install Rust (DO NOT TOUCH)
RUN apt-get update && apt-get install -y curl
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Copy project files into the container (JUST LEAVE 4 IMAGES for DB WHEN TESTING DOCKER IMAGE LOCALLY)
COPY . /app

# Set the working directory to the project
WORKDIR /app

# Run unit and integration tests (LAUNCHING TESTS)
ENTRYPOINT ["cargo", "test", "--release", "--"]
