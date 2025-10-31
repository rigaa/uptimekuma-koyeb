#!/bin/bash

echo "🚀 Starting UptimeKuma with B2 Backup..."

# Use virtual environment for B2 CLI
/app/venv/bin/b2 authorize-account "$B2_ACCOUNT_ID" "$B2_ACCOUNT_KEY"

# Restore data jika database tidak ada
if [ ! -f "/data/kuma.db" ]; then
    echo "🔁 Restoring database from B2..."
    /app/venv/bin/b2 download-file-by-name "$B2_BUCKET_NAME" "backups/kuma.db" "/data/kuma.db" || echo "ℹ️  No backup found, starting fresh"
fi

# Start UptimeKuma
echo "🎯 Starting UptimeKuma..."
exec node server/server.js
