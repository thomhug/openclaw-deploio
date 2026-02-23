#!/bin/bash
set -e

cd /app

# Copy config if not already present
if [ ! -f /home/node/.openclaw/openclaw.json ]; then
  mkdir -p /home/node/.openclaw
  cp /opt/openclaw-config/openclaw.json /home/node/.openclaw/openclaw.json
fi

# Start gateway on Deploio's $PORT (default 8080)
exec node openclaw.mjs gateway \
  --port "${PORT:-8080}" \
  --bind lan \
  --allow-unconfigured
