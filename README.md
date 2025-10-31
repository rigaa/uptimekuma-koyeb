
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

