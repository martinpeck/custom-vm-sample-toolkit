FROM mcr.microsoft.com/devcontainers/base:bullseye

# This will be set to true when running in VSCode
ARG INTERACTIVE="false"
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt-get update && apt-get install -y curl gnupg lsb-release bash-completion --no-install-recommends \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*
    
# Install AzCopy
RUN curl -L --fail -o /tmp/azcopy.tar.gz "https://aka.ms/downloadazcopy-v10-linux" \
  && tar -xvzf /tmp/azcopy.tar.gz -C /tmp \
  && cp /tmp/azcopy_linux_amd64_*/azcopy /usr/local/bin/azcopy \
  && chmod +x /usr/local/bin/azcopy

USER $USERNAME