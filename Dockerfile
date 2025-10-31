FROM louislam/uptime-kuma:2.0.2

# Switch to root untuk install dependencies
USER root

# Install dependencies for B2 CLI
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

# Create start script directly
RUN mkdir -p /app/scripts
RUN echo '#!/bin/bash\n\
# Start Uptime Kuma\n\
node server/server.js\n\
' > /app/scripts/start.sh && chmod +x /app/scripts/start.sh

# Switch back to node user
USER node

# Set working directory
WORKDIR /app

# Expose port
EXPOSE 3001

# Start script
CMD ["/bin/bash", "/app/scripts/start.sh"]
