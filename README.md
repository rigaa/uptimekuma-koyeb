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
   ```env
   B2_ACCOUNT_ID=your_account_id
   B2_ACCOUNT_KEY=your_application_key
   B2_BUCKET_NAME=your_bucket_name
