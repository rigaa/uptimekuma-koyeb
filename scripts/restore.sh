#!/bin/bash

echo "🔁 Restoring UptimeKuma database from B2..."

# Authorize B2
/app/venv/bin/b2 authorize-account "$B2_ACCOUNT_ID" "$B2_ACCOUNT_KEY"

# Restore hanya file kuma.db saja
echo "📥 Downloading kuma.db from B2..."
if /app/venv/bin/b2 download-file-by-name "$B2_BUCKET_NAME" "backups/kuma.db" "/app/data/kuma.db"; then
    echo "✅ Database restored successfully!"
    
    # Hapus file -wal dan -shm untuk fresh start
    echo "🧹 Cleaning temporary database files..."
    rm -f /app/data/kuma.db-wal /app/data/kuma.db-shm 2>/dev/null
else
    echo "❌ No backup found or restore failed. Starting with fresh database."
fi

echo "🎯 Restore process completed!"
