#!/bin/bash
set -e

cd /app

# Run onboarding non-interactively if not already configured
if [ ! -f /home/node/.openclaw/openclaw.json ]; then
  node openclaw.mjs onboard --non-interactive \
    --anthropic-api-key "$ANTHROPIC_API_KEY"
fi

# Start gateway on Deploio's $PORT (default 8080)
exec node openclaw.mjs gateway \
  --port "${PORT:-8080}" \
  --bind lan \
  --allow-unconfigured
