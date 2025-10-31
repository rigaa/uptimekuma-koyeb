# Uptime Kuma on Koyeb with Backblaze B2 Backup

Deploy Uptime Kuma on Koyeb with automated database backup and restore to Backblaze B2.

## Features

- **Uptime Kuma** - Self-hosted monitoring service
- **Koyeb Deployment** - Serverless cloud platform
- **Backblaze B2 Backup** - Automated database backups
- **Auto Restore** - Automatic database restoration on startup

## Quick Deployment

1. **Fork this repository**
2. **Set up Backblaze B2:**
   - Create B2 account
   - Create storage bucket
   - Generate Application Key
3. **Deploy on Koyeb:**
   - Go to [Koyeb Console](https://app.koyeb.com/)
   - Create new app
   - Connect GitHub repository
   - Set environment variables:
     ```
     B2_ACCOUNT_ID=your_account_id
     B2_ACCOUNT_KEY=your_application_key
     B2_BUCKET_NAME=your_bucket_name
     ```

## Manual Commands

```bash
# Manual backup
docker exec uptime-kuma /app/scripts/manual-backup.sh

# Manual restore
docker exec uptime-kuma /app/scripts/manual-restore.sh

# Auto backup
docker exec uptime-kuma /app/scripts/backup.sh

# Auto restore
docker exec uptime-kuma /app/scripts/restore.sh
