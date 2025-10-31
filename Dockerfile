FROM louislam/uptime-kuma:2.0.2

# Install Python and create virtual environment
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv curl

# Create virtual environment and install B2 CLI
RUN python3 -m venv /app/venv
RUN /app/venv/bin/pip install b2

# Copy all scripts
COPY backup.sh /app/backup.sh
COPY restore.sh /app/restore.sh
COPY keep-alive.sh /app/keep-alive.sh
COPY start.sh /app/start.sh

RUN chmod +x /app/backup.sh /app/restore.sh /app/keep-alive.sh /app/start.sh

# Start using the custom script (with restore + keep-alive)
CMD ["/bin/bash", "/app/start.sh"]
