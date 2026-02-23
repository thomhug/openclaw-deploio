#!/bin/bash
set -e

cd /app

# Copy config if not already present
if [ ! -f /home/node/.openclaw/openclaw.json ]; then
  mkdir -p /home/node/.openclaw
  cp /opt/openclaw-config/openclaw.json /home/node/.openclaw/openclaw.json
fi

# Static security audit before starting the gateway
echo "Running OpenClaw security audit..."
if ! node openclaw.mjs security audit 2>&1; then
  echo "SECURITY AUDIT FAILED – refusing to start gateway."
  exit 1
fi
echo "Security audit passed."

# Start gateway on Deploio's $PORT (default 8080)
exec node openclaw.mjs gateway \
  --port "${PORT:-8080}" \
  --bind lan \
  --allow-unconfigured
