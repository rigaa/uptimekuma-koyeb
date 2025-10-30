#!/bin/bash
echo "=========================================="
echo "🚀 UptimeKuma + Backblaze B2 Auto-Setup"
echo "=========================================="

# Install B2 CLI
echo "📦 Installing B2 CLI..."
pip3 install b2 -q

# Login to B2
echo "🔑 Authenticating with Backblaze B2..."
b2 authorize-account "$B2_ACCOUNT_ID" "$B2_ACCOUNT_KEY"

# Check if data exists, if not restore from B2
if [ ! -f "/data/kuma.db" ]; then
    echo "🔁 Data not found! Restoring from Backblaze B2..."
    b2 sync "b2://$B2_BUCKET_NAME/backups" /data
    
    # If still no data after restore, it's first setup
    if [ ! -f "/data/kuma.db" ]; then
        echo "🆕 First-time setup detected"
        echo "📝 Please complete UptimeKuma setup in browser"
        echo "💾 Data will be automatically backed up to B2"
    else
        echo "✅ Restore completed!"
    fi
else
    echo "✅ Data exists, skipping restore"
fi

# Backup current data to B2
echo "💾 Backing up data to Backblaze B2..."
b2 sync /data "b2://$B2_BUCKET_NAME/backups"
echo "✅ Backup completed!"

# Start UptimeKuma
echo "🎯 Starting UptimeKuma..."
exec node server/server.js
