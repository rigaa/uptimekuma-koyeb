FROM louislam/uptime-kuma:1

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

# Create scripts directory
RUN mkdir -p /app/scripts

# Copy scripts
COPY scripts/ /app/scripts/

# Make scripts executable
RUN chmod +x /app/scripts/*.sh

# Set working directory
WORKDIR /app

# Switch to node user
USER node

# Expose port
EXPOSE 3001

# Start script
CMD ["/app/scripts/start.sh"]
