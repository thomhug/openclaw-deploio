FROM ghcr.io/openclaw/openclaw:latest

ENV OPENCLAW_GATEWAY_BIND=lan
ENV OPENCLAW_GATEWAY_PORT=8080

EXPOSE 8080

COPY entrypoint.sh /entrypoint.sh
USER root
RUN chmod +x /entrypoint.sh
USER node

ENTRYPOINT ["/entrypoint.sh"]
