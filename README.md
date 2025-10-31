# Uptime Kuma on Koyeb with Healthchecks.io Keep-Alive

Deploy Uptime Kuma on Koyeb with automatic keep-alive using Healthchecks.io to prevent instance sleeping.

## 🚀 Features

- Uptime Kuma 2.0.2
- Backblaze B2 CLI integration
- Healthchecks.io keep-alive system
- Prevents Koyeb free tier sleeping
- Automatic monitoring

## ⚙️ Setup Instructions

### 1. Healthchecks.io Configuration

#### Create Healthchecks.io Account
1. Visit [healthchecks.io](https://healthchecks.io/)
2. Sign up for a free account (20 checks available)

#### Create Check in Healthchecks.io
1. Click **"Add Check"**
2. Configure the check:
   - **Name**: `Uptime Kuma Keep-Alive`
   - **Schedule**: `*/4 * * * *` (every 4 minutes)
   - **Timezone**: Your timezone
   - **Grace Period**: `1 minute`

3. **Save** and copy your **Ping URL** (looks like: `https://hc-ping.com/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`)

### 2. Koyeb Deployment

#### Environment Variables
Set these environment variables in your Koyeb app:

| Variable Name | Value | Description |
|---------------|-------|-------------|
| `HEALTHCHECKS_PING_URL` | `https://hc-ping.com/your-unique-id` | Your Healthchecks.io ping URL |
| `KOYEB_APP_NAME` | `your-app-name` | Your Koyeb app name |

#### Deploy to Koyeb
1. Fork this repository
2. Connect your GitHub repo to Koyeb
3. Deploy with the environment variables above

## 🔧 How It Works

### Keep-Alive Mechanism
- The Docker container runs a background script that pings your Uptime Kuma instance every 4 minutes
- Simultaneously pings Healthchecks.io to confirm the keep-alive is working
- Prevents Koyeb from putting your instance to sleep (Koyeb sleeps after 5 minutes of inactivity)

### Healthchecks.io Monitoring
- Healthchecks.io expects a ping every 4 minutes
- If no ping is received within 5 minutes, it triggers an alert
- You can set up notifications via email, Slack, Discord, etc.

## 📊 Verification

### Check if Keep-Alive is Working

1. **Healthchecks.io Dashboard**:
   - Green check = System is active
   - Red cross = No recent ping

2. **Koyeb Logs**:
