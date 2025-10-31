FROM louislam/uptime-kuma:2.0.2

USER root

# Install dependencies for B2 CLI and healthchecks
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment for B2 CLI
RUN python3 -m venv /app/venv

# Install B2 CLI in virtual environment
RUN /app/venv/bin/pip install --no-cache-dir b2

# Create healthchecks.io keep-alive script using HEREDOC syntax
RUN cat > /app/healthchecks-keep-alive.sh << 'EOF'
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
    
    # Wait 4 minutes (240 seconds)
    sleep 240
done
EOF

RUN chmod +x /app/healthchecks-keep-alive.sh

# Create main start script
RUN cat > /app/start.sh << 'EOF'
#!/bin/bash
# Main startup script for Uptime Kuma with Healthchecks.io integration

echo "=== Starting Uptime Kuma with Healthchecks.io Keep-Alive ==="

# Start healthchecks keep-alive in background
echo "Starting Healthchecks.io keep-alive service..."
bash /app/healthchecks-keep-alive.sh &

# Start Uptime Kuma
echo "Starting Uptime Kuma..."
exec node server/server.js
EOF

RUN chmod +x /app/start.sh

# Create data directory with proper permissions
RUN mkdir -p /data && chown -R node:node /data

# Switch back to node user
USER node

# Set working directory
WORKDIR /app

# Expose port
EXPOSE 3001

# Start using the custom script
CMD ["/bin/bash", "/app/start.sh"]
