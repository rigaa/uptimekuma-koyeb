#!/bin/bash
# Healthchecks.io Keep-Alive Script for Koyeb

echo "Healthchecks keep-alive script started"

while true; do
    # Ping healthchecks.io
    if [ ! -z "$HEALTHCHECKS_PING_URL" ]; then
        curl -f -s -o /dev/null --max-time 10 "$HEALTHCHECKS_PING_URL" && echo "Healthchecks ping sent" || echo "Healthchecks ping failed"
    fi
    
    # Also ping our own app to keep it awake
    if [ ! -z "$KOYEB_APP_NAME" ]; then
        curl -f -s -o /dev/null --max-time 10 "https://${KOYEB_APP_NAME}.koyeb.app" && echo "App ping sent" || echo "App ping failed"
    fi
    
    # Wait 2 minutes (240 seconds)
    sleep 120
done
