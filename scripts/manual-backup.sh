#!/bin/bash

echo "🛠️  Manual Backup UptimeKuma Database"

# Authorize B2
/app/venv/bin/b2 authorize-account "$B2_ACCOUNT_ID" "$B2_ACCOUNT_KEY"

# Cek jika database ada
if [ ! -f "/app/data/kuma.db" ]; then
    echo "❌ Error: Database file /app/data/kuma.db not found!"
    exit 1
fi

# Create backup dengan timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="kuma.db.backup_$TIMESTAMP"

echo "📤 Creating manual backup: $BACKUP_NAME"

# Upload backup file
if /app/venv/bin/b2 upload-file "$B2_BUCKET_NAME" "/app/data/kuma.db" "backups/$BACKUP_NAME"; then
    echo "✅ Manual backup created: $BACKUP_NAME"
    
    # List semua backup yang ada
    echo "📋 Available backups:"
    /app/venv/bin/b2 ls "$B2_BUCKET_NAME" backups/ | grep kuma.db
else
    echo "❌ Manual backup failed!"
    exit 1
fi
