FROM louislam/uptime-kuma:2.0.2

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

# Create healthchecks.io keep-alive script
RUN echo '#!/bin/bash\n\
# Healthchecks.io Keep-Alive Script for Koyeb\n\
# This script prevents the Koyeb instance from sleeping\n\
\n\
PING_URL=\"${HEALTHCHECKS_PING_URL}\"\n\
APP_URL=\"https://${KOYEB_APP_NAME}.koyeb.app\"\n\
LOG_FILE=\"/tmp/healthchecks.log\"\n\
\n\
echo \"$(date): Starting Healthchecks.io keep-alive script\" >> $LOG_FILE\n\
echo \"$(date): App URL: $APP_URL\" >> $LOG_FILE\n\
echo \"$(date): Ping URL: $PING_URL\" >> $LOG_FILE\n\
\n\
while true; do\n\
    TIMESTAMP=$(date \"+%Y-%m-%d %H:%M:%S\")\n\
    \n\
    # Check if Uptime Kuma is responding\n\
    if curl -f -s -o /dev/null --max-time 10 \"$APP_URL\"; then\n\
        # Uptime Kuma is up - send success ping to healthchecks\n\
        if curl -f -s -o /dev/null --max-time 10 \"$PING_URL\"; then\n\
            echo \"$TIMESTAMP: ✅ Success - App responsive & ping sent\" >> $LOG_FILE\n\
        else\n\
            echo \"$TIMESTAMP: ⚠️  Warning - App up but ping failed\" >> $LOG_FILE\n\
        fi\n\
    else\n\
        # Uptime Kuma is down - send failure ping\n\
        echo \"$TIMESTAMP: ❌ Error - App not responding\" >> $LOG_FILE\n\
        curl -f -s -o /dev/null --max-time 10 \"$PING_URL/fail\" || true\n\
    fi\n\
    \n\
    # Wait 4 minutes (240 seconds) before next ping\n\
    # Koyeb sleeps after 5 minutes of inactivity\n\
    sleep 240\n\
done\n\
' > /app/healthchecks-keep-alive.sh && chmod +x /app/healthchecks-keep-alive.sh

# Create main start script
RUN echo '#!/bin/bash\n\
# Main startup script for Uptime Kuma with Healthchecks.io integration\n\
\n\
# Start healthchecks keep-alive in background\n\
echo \"Starting Healthchecks.io keep-alive service...\"\n\
bash /app/healthchecks-keep-alive.sh &\n\
\n\
# Start Uptime Kuma\n\
echo \"Starting Uptime Kuma...\"\n\
node server/server.js\n\
' > /app/start.sh && chmod +x /app/start.sh

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
