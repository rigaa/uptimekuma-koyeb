# Uptime Kuma on Koyeb with Healthchecks.io Keep-Alive

Deploy Uptime Kuma on Koyeb with automatic keep-alive using Healthchecks.io to prevent instance sleeping.

## 🚀 Quick Setup

### 1. Create Healthchecks.io Account
- Go to [healthchecks.io](https://healthchecks.io/) and sign up
- Create a new check with:
  - **Name**: `Uptime Kuma Keep-Alive`
  - **Schedule**: `*/4 * * * *` (every 4 minutes)
  - **Timezone**: Your timezone
  - **Grace Time**: `1 minute`

### 2. Get Your Ping URL
- Copy the **Ping URL** from your check (format: `https://hc-ping.com/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`)

### 3. Set Koyeb Environment Variables
In your Koyeb app dashboard, go to **Settings** → **Environment Variables** and add:

| Variable | Value | Example |
|----------|-------|---------|
| `HEALTHCHECKS_PING_URL` | Your Ping URL from healthchecks.io | `https://hc-ping.com/12345678-1234-1234-1234-123456789abc` |
| `KOYEB_APP_NAME` | Your Koyeb app name | `my-uptime-kuma` |

### 4. Deploy
- This repository will auto-deploy on Koyeb
- The keep-alive script will run automatically

## 🔧 How It Works

- A background script pings both healthchecks.io and your app every 4 minutes
- Prevents Koyeb from putting your instance to sleep (sleeps after 5 minutes inactivity)
- Healthchecks.io monitors if the keep-alive is working
- You get alerts if the keep-alive stops working

## 📊 Verification

### Check if Keep-Alive is Working

1. **Healthchecks.io Dashboard**: Should show green checkmarks
2. **Koyeb Logs**: Look for "Healthchecks ping sent" messages
3. **Manual Test**: 
   ```bash
   curl -I https://your-app-name.koyeb.app

🔔 Notifications Setup
Healthchecks.io Notifications
Go to your check in Healthchecks.io

Click "Add Integration"

Choose your preferred notification method:

Email

Slack

Discord

Telegram

Webhook

Example Slack Notification
text
🔴 Uptime Kuma Keep-Alive FAILED
Last ping: 6 minutes ago
Check: https://healthchecks.io/checks/your-check-id/
🛠️ Troubleshooting
Common Issues
Instance still sleeping

Check that HEALTHCHECKS_PING_URL is set correctly

Verify the ping interval is less than 5 minutes

Healthchecks.io showing failures

Check Koyeb logs for errors

Verify your app URL is accessible

Uptime Kuma not starting

Check environment variables

Verify data directory permissions

Logs Location
Keep-alive logs: /tmp/healthchecks.log

Application logs: Koyeb dashboard → Logs

📝 Environment Variables Reference
Variable	Required	Description
HEALTHCHECKS_PING_URL	Yes	Your Healthchecks.io ping URL
KOYEB_APP_NAME	Yes	Your Koyeb application name
DATA_DIR	No	Data directory (default: /data)
🤝 Contributing
Feel free to submit issues and enhancement requests!

📄 License
This project is licensed under the MIT License.

text

## 3. Cara Menggunakan:

1. **Salin Dockerfile** di atas ke repository Anda
2. **Tambahkan README.md** dengan konten di atas  
3. **Setup Healthchecks.io** seperti di panduan
4. **Deploy di Koyeb** dengan environment variables:
   - `HEALTHCHECKS_PING_URL`
   - `KOYEB_APP_NAME`

## 4. Environment Variables di Koyeb:
HEALTHCHECKS_PING_URL = https://hc-ping.com/your-unique-id-from-healthchecks
KOYEB_APP_NAME = your-koyeb-app-name

text

Dengan setup ini, Uptime Kuma Anda akan tetap aktif 24/7 meski menggunakan plan gratis Koyeb! 🚀



