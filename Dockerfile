FROM louislam/uptime-kuma:2.0.2

# Install Python and create virtual environment
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv

# Create virtual environment and install B2 CLI
RUN python3 -m venv /app/venv
RUN /app/venv/bin/pip install b2

# Copy backup scripts
COPY backup.sh /app/backup.sh
COPY restore.sh /app/restore.sh
RUN chmod +x /app/backup.sh /app/restore.sh

# Start UptimeKuma directly (NO auto backup/restore)
CMD ["node", "server/server.js"]
