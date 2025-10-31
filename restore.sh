#!/bin/bash
echo "=========================================="
echo "🔁 MANUAL RESTORE FROM BACKBLAZE B2"
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

# Perform restore
echo "🔄 Restoring data from B2 to /data..."
/app/venv/bin/b2 sync "b2://$B2_BUCKET_NAME/backups" /data

echo "✅ Restore completed successfully!"
echo "📊 Files restored to /data:"
ls -la /data/

echo ""
echo "💾 To backup again, run: /app/backup.sh"
