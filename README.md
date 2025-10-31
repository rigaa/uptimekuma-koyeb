# Uptime Kuma on Koyeb with Healthchecks.io Keep-Alive

Deploy Uptime Kuma on Koyeb with automatic keep-alive using Healthchecks.io to prevent instance sleeping on free tier.

## 🚀 Features

- Uptime Kuma 2.0.2
- Backblaze B2 CLI integration for backups
- Healthchecks.io keep-alive system
- Prevents Koyeb free tier sleeping
- Automatic backup restore on deployment

## ⚡ Quick Start

### 1. Healthchecks.io Setup

1. **Create Account** at [healthchecks.io](https://healthchecks.io/)
2. **Create New Check**:
   - **Name**: `Uptime Kuma Keep-Alive`
   - **Schedule**: `*/4 * * * *` (every 4 minutes)
   - **Timezone**: Your timezone
   - **Grace Time**: `1 minute`
3. **Copy Ping URL** (format: `https://hc-ping.com/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`)

### 2. Koyeb Deployment

1. **Fork this repository**
2. **Deploy to Koyeb** and set these environment variables:

| Environment Variable | Value | Description |
|---------------------|-------|-------------|
| `HEALTHCHECKS_PING_URL` | `https://hc-ping.com/your-id` | Your Healthchecks.io ping URL |
| `KOYEB_APP_NAME` | `your-app-name` | Your Koyeb application name |

### 3. Optional: Backblaze B2 Backup

Set these variables for automatic backups:

| Environment Variable | Value | Description |
|---------------------|-------|-------------|
| `B2_APPLICATION_KEY_ID` | `your-key-id` | B2 Application Key ID |
| `B2_APPLICATION_KEY` | `your-application-key` | B2 Application Key |
| `B2_BUCKET_NAME` | `your-bucket-name` | B2 Bucket name |

## 🔧 How It Works

### Keep-Alive System
- Background script pings Healthchecks.io every 4 minutes
- Prevents Koyeb from sleeping instances (5-minute threshold)
- Healthchecks.io monitors keep-alive status
- Automatic alerts if keep-alive fails

### Backup & Restore System
- Automatic restore from B2 backup on first deployment
- Manual backup script included
- Data persistence across deployments






## 🐛 Troubleshooting

### Instance Still Sleeping
- Verify `HEALTHCHECKS_PING_URL` is set correctly
- Check that ping interval is less than 5 minutes
- Review Koyeb logs for errors

### Healthchecks.io Not Receiving Pings
- Check environment variables in Koyeb dashboard
- Verify Healthchecks.io check is active
- Test ping URL manually: `curl -v YOUR_PING_URL`

### Backup/Restore Issues
- Ensure B2 credentials are correct
- Check bucket exists and is accessible
- Verify backup files are in correct format

## 🔔 Notifications

Setup notifications in Healthchecks.io:
1. Go to your check → "Add Integration"
2. Choose notification method:
   - **Email**
   - **Slack**
   - **Discord**
   - **Telegram**
   - **Webhook**

## 📊 Verification

### Check Keep-Alive Status
1. **Healthchecks.io Dashboard**: Should show green checkmarks
2. **Koyeb Logs**: Look for ping success messages
3. **Manual Test**: Access your app URL

### Check Application
- Visit: `https://your-app-name.koyeb.app`
- Complete Uptime Kuma setup
- Configure your monitors

## 🛠️ Manual Commands

### Run Manual Backup
```bash
docker exec [container-name] /app/backup.sh

## 📁 File Structure
