#!/bin/bash

echo "🔁 Restoring UptimeKuma database from B2..."

# Authorize B2
/app/venv/bin/b2 authorize-account "$B2_ACCOUNT_ID" "$B2_ACCOUNT_KEY"

# Restore hanya file kuma.db saja
echo "📥 Downloading kuma.db from B2..."
if /app/venv/bin/b2 download-file-by-name "$B2_BUCKET_NAME" "backups/kuma.db" "/data/kuma.db"; then
    echo "✅ Database restored successfully!"
    
    # Hapus file -wal dan -shm untuk fresh start
    echo "🧹 Cleaning temporary database files..."
    rm -f /data/kuma.db-wal /data/kuma.db-shm 2>/dev/null
    
    echo "📊 Restored file info:"
    ls -la /data/kuma.db
else
    echo "❌ No backup found or restore failed. Starting with fresh database."
fi

echo "🎯 Restore process completed!"
