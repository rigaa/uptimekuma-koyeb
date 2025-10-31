#!/bin/bash
echo "=========================================="
echo "🔁 MANUAL BACKUP TO BACKBLAZE B2"
echo "=========================================="

# Check if environment variables are set
if [ -z "$B2_ACCOUNT_ID" ] || [ -z "$B2_ACCOUNT_KEY" ] || [ -z "$B2_BUCKET_NAME" ]; then
    echo "❌ ERROR: Missing environment variables"
    echo "Please set: B2_ACCOUNT_ID, B2_ACCOUNT_KEY, B2_BUCKET_NAME"
    exit 1
fi

# Use virtual environment for B2 CLI
echo "🔑 Authenticating to Backblaze B2..."
/app/venv/bin/b2 authorize-account "$B2_ACCOUNT_ID" "$B2_ACCOUNT_KEY"

# Perform backup
echo "💾 Backing up data from /data to B2..."
/app/venv/bin/b2 sync /data "b2://$B2_BUCKET_NAME/backups"

echo "✅ Backup completed successfully!"
echo "📊 Files in backup storage:"
/app/venv/bin/b2 ls "$B2_BUCKET_NAME" --recursive

echo ""
echo "🚀 To restore later, run: /app/restore.sh"
