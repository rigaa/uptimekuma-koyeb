markdown
# Uptime Kuma on Koyeb with Backblaze B2 Backup

Deploy Uptime Kuma on Koyeb with automated Backblaze B2 backup and restore functionality.

## Features

- **Uptime Kuma** - Self-hosted monitoring tool
- **Backblaze B2 Integration** - Automated database backups
- **Koyeb Deployment** - Easy cloud deployment
- **Database Backup/Restore** - Manual and automated backup solutions
- **Dockerized** - Containerized deployment

## Project Structure
uptimekuma-koyeb/
├── scripts/
│ ├── start.sh
│ ├── backup.sh
│ ├── restore.sh
│ ├── manual-backup.sh
│ └── manual-restore.sh
├── Dockerfile
├── docker-compose.yml
└── README.md

text

## Setup Instructions

### 1. Environment Variables

Set these environment variables in your Koyeb deployment:

```env
B2_ACCOUNT_ID=your_account_id_here
B2_ACCOUNT_KEY=your_application_key_here
B2_BUCKET_NAME=your_bucket_name_here
2. Backblaze B2 Configuration
Create a Backblaze B2 account

Create a bucket for backups

Generate Application Key with read/write permissions

3. Koyeb Deployment
Method 1: Using Koyeb Web Interface
Go to Koyeb Control Panel

Click "Create App"

Select "GitHub" as deployment method

Choose your repository

Set environment variables

Deploy

Method 2: Using Koyeb CLI
bash
koyeb app create uptime-kuma \
  --git github.com/yourusername/uptimekuma-koyeb \
  --git-branch main \
  --ports 3001:http \
  --env B2_ACCOUNT_ID=your_id \
  --env B2_ACCOUNT_KEY=your_key \
  --env B2_BUCKET_NAME=your_bucket
Backup & Restore
Automated Backup
Backups run automatically on deployment

Only backs up kuma.db (main database file)

Excludes temporary files (-wal, -shm)

Manual Backup
bash
docker exec [container-name] /app/scripts/manual-backup.sh
Manual Restore
bash
docker exec [container-name] /app/scripts/manual-restore.sh
Available Scripts
Script	Purpose
start.sh	Main startup (auto-restore)
backup.sh	Automated backup
restore.sh	Automated restore
manual-backup.sh	Manual backup with timestamp
manual-restore.sh	Manual restore with backup selection
Database Management
Backed Up Files
kuma.db - Main database file

Excluded Files
kuma.db-wal - Write-ahead log (temporary)

kuma.db-shm - Shared memory (temporary)

screenshots/ - Monitor screenshots

upload/ - Uploaded files

Manual Deployment
Using Docker Compose
bash
git clone https://github.com/yourusername/uptimekuma-koyeb.git
cd uptimekuma-koyeb

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
  yourimage:latest
Monitoring
Access your Uptime Kuma dashboard at:

text
http://your-app.koyeb.app:3001
Troubleshooting
Common Issues
Backup Fails

Check B2 credentials

Verify bucket permissions

Check network connectivity

Restore Fails

Verify backup exists in B2

Check database file permissions

Ensure sufficient disk space

Database Corruption

Use manual restore to select previous backup

Check logs in /data/backup.log

Logs
Check application logs in Koyeb dashboard or via:

bash
koyeb service logs [service-name]
Security Notes
Keep B2 credentials secure

Regularly rotate application keys

Monitor backup success/failure

Test restore process periodically

License
This project is licensed under the MIT License.

Support
If you encounter any issues:

Check the troubleshooting section

Review Koyeb deployment logs

Check Backblaze B2 bucket permissions

Open an issue on GitHub

