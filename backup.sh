#!/bin/bash

echo "💾 Backing up UptimeKuma database to B2..."

# Authorize B2
/app/venv/bin/b2 authorize-account "$B2_ACCOUNT_ID" "$B2_ACCOUNT_KEY"

# Backup hanya file kuma.db saja
if [ -f "/data/kuma.db" ]; then
    echo "📤 Uploading kuma.db to B2..."
    
    # Hapus backup lama terlebih dahulu (optional)
    /app/venv/bin/b2 delete-file-version "backups/kuma.db" 2>/dev/null || true
    
    # Upload file database
    if /app/venv/bin/b2 upload-file "$B2_BUCKET_NAME" "/data/kuma.db" "backups/kuma.db"; then
        echo "✅ Database backed up successfully!"
        echo "📊 Backup file info:"
        /app/venv/bin/b2 ls "$B2_BUCKET_NAME" backups/
    else
        echo "❌ Backup failed!"
        exit 1
    fi
else
    echo "❌ Database file not found: /data/kuma.db"
    exit 1
fi

echo "🎯 Backup process completed!"
