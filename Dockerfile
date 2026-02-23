FROM ghcr.io/openclaw/openclaw:latest

# Copy pre-configured config (API key comes from env var)
COPY config/openclaw.json /opt/openclaw-config/openclaw.json

ENV OPENCLAW_GATEWAY_BIND=lan
ENV OPENCLAW_GATEWAY_PORT=8080

EXPOSE 8080

COPY entrypoint.sh /entrypoint.sh
USER root
RUN chmod +x /entrypoint.sh
USER node

ENTRYPOINT ["/entrypoint.sh"]
