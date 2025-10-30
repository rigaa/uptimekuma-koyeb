FROM louislam/uptimekuma:latest

# Install Python and B2 CLI
RUN apt-get update && apt-get install -y python3 python3-pip
RUN pip3 install b2

# Copy startup script
COPY startup.sh /app/startup.sh
RUN chmod +x /app/startup.sh

# Use our startup script
CMD ["/bin/bash", "/app/startup.sh"]
