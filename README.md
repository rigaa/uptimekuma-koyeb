# Uptime Kuma on Koyeb with Backblaze B2 Backup

Deploy Uptime Kuma on Koyeb with automated database backup and restore to Backblaze B2.

## 🚀 Features

- **Uptime Kuma** - Self-hosted monitoring service
- **Koyeb Deployment** - Serverless cloud platform
- **Backblaze B2 Backup** - Automated database backups
- **Auto Restore** - Automatic database restoration on startup
- **Manual Backup/Restore** - Full control over backup operations

## 📋 Prerequisites

- [Koyeb Account](https://www.koyeb.com/)
- [Backblaze B2 Account](https://www.backblaze.com/b2/)
- GitHub Account

## ⚡ Quick Deployment

### 1. Fork this Repository
Click "Fork" button to create your copy of this repository.

### 2. Backblaze B2 Setup

1. Create Backblaze B2 account
2. Create a storage bucket
3. Generate Application Key with:
   - Read & Write permissions
   - Access to your bucket

### 3. Deploy on Koyeb

#### Method 1: Web Interface

1. Go to [Koyeb Console](https://app.koyeb.com/)
2. Click "Create App"
3. Select "GitHub" → Choose this repository
4. Set environment variables:
   
   B2_ACCOUNT_ID=your_account_id
   B2_ACCOUNT_KEY=your_application_key
   B2_BUCKET_NAME=your_bucket_name


🔧 Environment Variables
Variable	Description	Required
B2_ACCOUNT_ID	Backblaze B2 Account ID	✅
B2_ACCOUNT_KEY	Backblaze B2 Application Key	✅
B2_BUCKET_NAME	Backblaze B2 Bucket Name	✅

📁 Project Structure
text
uptimekuma-koyeb/
├── scripts/
│   ├── start.sh           # Main startup script
│   ├── backup.sh          # Automated backup
│   ├── restore.sh         # Automated restore
│   ├── manual-backup.sh   # Manual backup
│   └── manual-restore.sh  # Manual restore
├── Dockerfile
├── docker-compose.yml
└── README.md


🔄 Backup & Restore
Automated Operations
Auto-restore on startup if database missing

Backup runs during deployment

Only kuma.db is backed up (excludes temporary files)


Manual Commands
bash
# Manual backup with timestamp
docker exec [container] /app/scripts/manual-backup.sh

# Manual restore with backup selection
docker exec [container] /app/scripts/manual-restore.sh

Backup Files
✅ Backed up: kuma.db (main database)

❌ Not backed up: kuma.db-wal, kuma.db-shm, screenshots/, upload/


🐳 Local Development
Using Docker Compose
bash
git clone https://github.com/rigaa/uptimekuma-koyeb.git
cd uptimekuma-koyeb

# Set environment variables
export B2_ACCOUNT_ID=your_id
export B2_ACCOUNT_KEY=your_key
export B2_BUCKET_NAME=your_bucket

docker-compose up -d


Using Docker
bash
docker run -d \
  --name uptime-kuma \
  -p 3001:3001 \
  -v ./data:/app/data \
  -e B2_ACCOUNT_ID=your_id \
  -e B2_ACCOUNT_KEY=your_key \
  -e B2_BUCKET_NAME=your_bucket \
  ghcr.io/rigaa/uptimekuma-koyeb:1.2


🌐 Access Application
After deployment, access your Uptime Kuma at:

text
https://[your-app-name].koyeb.app

🛠️ Scripts Overview
start.sh
Main application entry point

Auto-restores database if missing
Starts Uptime Kuma server

backup.sh
Backs up kuma.db to Backblaze B2

Uses B2 CLI for upload

Error handling and logging

restore.sh
Restores database from B2

Cleans temporary files

Status reporting

manual-backup.sh
Creates timestamped backups

Lists available backups

Interactive backup creation

manual-restore.sh
Shows backup versions

Interactive restore process

Backup selection

❗ Troubleshooting
Common Issues
Backup Fails:

Verify B2 credentials

Check bucket permissions

Test network connectivity

Restore Fails:

Confirm backup exists in B2

Check /data directory permissions

Verify disk space

Database Issues:

Use manual-restore.sh for recovery

Check Koyeb application logs

Verify file integrity




