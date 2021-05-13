FROM gitpod/workspace-full

# More information: https://www.gitpod.io/docs/config-docker/
ENV PATH /home/linuxbrew/.linuxbrew/bin:$PATH

RUN brew install hugo && \
    brew install gh
