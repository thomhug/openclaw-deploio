#!/bin/bash
set -e

cd /app

# Generate config from template using environment variables
mkdir -p /home/node/.openclaw
envsubst < /opt/openclaw-config/openclaw.json.template > /home/node/.openclaw/openclaw.json

# Harden file permissions (security audit requirement)
chmod 700 /home/node/.openclaw
chmod 600 /home/node/.openclaw/openclaw.json

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
