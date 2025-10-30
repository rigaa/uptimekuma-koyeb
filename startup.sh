#!/bin/bash
echo "🚀 Starting UptimeKuma with B2 Backup..."

# Use virtual environment for B2 CLI
/app/venv/bin/b2 authorize-account "$B2_ACCOUNT_ID" "$B2_ACCOUNT_KEY"

# Restore data if empty
if [ ! -f "/data/kuma.db" ]; then
    echo "🔁 Restoring from B2..."
    /app/venv/bin/b2 sync "b2://$B2_BUCKET_NAME/backups" /data || echo "No backup found, fresh start"
fi

# Start UptimeKuma
echo "🎯 Starting UptimeKuma..."
exec node server/server.js
