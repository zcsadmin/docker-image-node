ARG NODE_VERSION=22

#
# Base image
#
FROM node:${NODE_VERSION}-bookworm-slim AS base

ARG DOCKER_USER=bob
ARG DOCKER_GROUP=bob

# Rename node user and group
RUN usermod -l ${DOCKER_USER} node && \
    groupmod -n ${DOCKER_GROUP} node && \
    mv /home/node /home/${DOCKER_USER} && \
    usermod -d /home/${DOCKER_USER} ${DOCKER_USER}

# Create app directory
RUN mkdir /app && \
    chown -R ${DOCKER_USER}:${DOCKER_GROUP} /app

# Set working directory
WORKDIR /app

# Run as normal user
USER ${DOCKER_USER}


#
# Dev image
#
FROM base AS dev

# Add fix-perm.sh script to image
USER 0
COPY ./fix-perm.sh /fix-perm.sh
RUN chmod +x /fix-perm.sh

USER ${DOCKER_USER}

# Set entrypoint so the container will run without doing anything
ENTRYPOINT ["/bin/sleep", "infinity"]


#
# Dist image
#
FROM base AS dist
