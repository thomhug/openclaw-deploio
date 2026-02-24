FROM ghcr.io/openclaw/openclaw:latest

ARG TELEGRAM_ALLOW_FROM
ENV TELEGRAM_ALLOW_FROM=$TELEGRAM_ALLOW_FROM

# Copy config template (envsubst generates final config at runtime)
COPY config/openclaw.json.template /opt/openclaw-config/openclaw.json.template

ENV OPENCLAW_GATEWAY_BIND=lan
ENV OPENCLAW_GATEWAY_PORT=8080

EXPOSE 8080

COPY entrypoint.sh /entrypoint.sh
USER root
RUN apt-get update && apt-get install -y --no-install-recommends gettext-base && rm -rf /var/lib/apt/lists/*
RUN chmod +x /entrypoint.sh
USER node

ENTRYPOINT ["/entrypoint.sh"]
