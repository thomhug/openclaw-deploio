FROM node:22-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g openclaw@latest

RUN mkdir -p /home/node/.openclaw
WORKDIR /home/node

ENV OPENCLAW_GATEWAY_BIND=lan
ENV OPENCLAW_HOME=/home/node

EXPOSE 8080

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
