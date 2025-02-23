# This Dockerfile is based on godot-ci by abarichello
# Source: https://github.com/abarichello/godot-ci
# Licensed under the MIT License

FROM mcr.microsoft.com/dotnet/sdk:latest AS builder

# Setup environment variables
ENV PATH="/usr/share/dotnet:${PATH}" \
    DOTNET_ROOT="/usr/share/dotnet" \
    GODOT_VERSION="4.3" \
    RELEASE_NAME="stable" \
    GODOT_TEST_ARGS="" \
    GAME_ENGINE_DIR="gs://game-engine" \
    GSUTIL_DEST="~/godot_server" \
    EXPORT_TEMPLATES_DIR="~/.local/share/godot/export_templates/${GODOT_VERSION}.${RELEASE_NAME}.mono"
    EDITOR_DEST="/root/.config/godot"

# Install required tools and dependencies
RUN apt-get update && apt-get install -y \
    wget \
	apt-transport-https \
	software-properties-common \
	lsb-release \
	gpg \
	curl \
    wine64 \
    unzip

# Add Google Cloud SDK repository
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
    apt-get update && apt-get install -y google-cloud-sdk

RUN wget https://github.com/electron/rcedit/releases/download/v1.1.1/rcedit-x64.exe -O /usr/local/bin/rcedit.exe

# Create required directories
RUN mkdir -p ~/.cache/ && \
    mkdir -p ~/.config/godot/ && \
    mkdir -p ~/godot_server/

# Copy your scripts into the container
COPY scripts/ /scripts/
RUN chmod +x /scripts/*.sh

# Set working directory to workspace
WORKDIR /workspace

CMD ["/bin/bash"]