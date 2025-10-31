FROM louislam/uptime-kuma:2.0.2

# Install Python and B2 CLI (for manual backup only)
RUN apt-get update && apt-get install -y python3 python3-pip
RUN pip3 install b2

# Copy backup scripts
COPY backup.sh /app/backup.sh
COPY restore.sh /app/restore.sh
RUN chmod +x /app/backup.sh /app/restore.sh

# Start UptimeKuma directly (NO auto backup/restore)
CMD ["node", "server/server.js"]
