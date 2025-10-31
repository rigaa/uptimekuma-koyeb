#!/bin/bash

echo "🛠️  Manual Restore UptimeKuma Database"

# Authorize B2
/app/venv/bin/b2 authorize-account "$B2_ACCOUNT_ID" "$B2_ACCOUNT_KEY"

# List available backups
echo "📋 Available backups:"
/app/venv/bin/b2 ls "$B2_BUCKET_NAME" backups/ | grep kuma.db

echo ""
echo "Enter backup filename to restore (or press enter for latest kuma.db):"
read -r BACKUP_FILE

# Jika tidak ada input, gunakan kuma.db (latest)
if [ -z "$BACKUP_FILE" ]; then
    BACKUP_FILE="kuma.db"
    echo "🔄 Restoring latest backup: $BACKUP_FILE"
else
    echo "🔄 Restoring: $BACKUP_FILE"
fi

# Backup database saat ini terlebih dahulu
if [ -f "/app/data/kuma.db" ]; then
    echo "💾 Backing up current database..."
    cp /app/data/kuma.db "/app/data/kuma.db.backup_$(date +%Y%m%d_%H%M%S)"
fi

# Download dan restore
if /app/venv/bin/b2 download-file-by-name "$B2_BUCKET_NAME" "backups/$BACKUP_FILE" "/app/data/kuma.db"; then
    echo "✅ Database restored successfully!"
    
    # Hapus temporary files
    rm -f /app/data/kuma.db-wal /app/data/kuma.db-shm 2>/dev/null
    echo "🧹 Temporary files cleaned"
    
    echo "📊 Restored file:"
    ls -la /app/data/kuma.db
else
    echo "❌ Restore failed!"
    exit 1
fi
