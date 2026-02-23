#!/bin/bash
set -e

# Run onboarding non-interactively if not already configured
if [ ! -f /home/node/.openclaw/openclaw.json ]; then
  openclaw onboard --non-interactive \
    --anthropic-api-key "$ANTHROPIC_API_KEY"
fi

# Start gateway on Deploio's $PORT (default 8080)
exec openclaw gateway --port "${PORT:-8080}" --bind lan
