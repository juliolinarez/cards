# Fly.io Deployment Guide

This guide explains how to deploy your Rails application to Fly.io.

## Prerequisites

1. **Fly CLI**: Install the Fly.io CLI tool
2. **Fly.io Account**: Create a free account at [fly.io](https://fly.io)
3. **Docker**: Ensure Docker is installed for local testing (optional)

## Quick Setup

### 1. Install Fly CLI (if not already installed)

```bash
curl -L https://fly.io/install.sh | sh
```

### 2. Run the setup script

```bash
bin/fly_setup
```

This script will:
- Check if you're logged into Fly.io
- Create your app on Fly.io
- Set up a PostgreSQL database
- Configure necessary environment variables

### 3. Deploy your application

```bash
bin/fly_deploy
```

## Manual Setup (Alternative)

If you prefer to set up manually:

### 1. Login to Fly.io

```bash
fly auth login
```

### 2. Create the app

```bash
fly apps create cards --org personal
```

### 3. Create PostgreSQL database

```bash
fly postgres create --name cards-db --region ord --vm-size shared-cpu-1x --volume-size 1
fly postgres attach cards-db --app cards
```

### 4. Set environment variables

```bash
fly secrets set \
  RAILS_ENV=production \
  RAILS_SERVE_STATIC_FILES=true \
  RAILS_LOG_TO_STDOUT=true \
  SECRET_KEY_BASE=$(openssl rand -hex 64) \
  --app cards
```

### 5. Deploy

```bash
fly deploy --dockerfile Dockerfile.fly
```

## Configuration Files

The following files have been configured for Fly.io deployment:

- **`fly.toml`**: Main Fly.io configuration
- **`Dockerfile.fly`**: Optimized Dockerfile for Fly.io
- **`config/database.yml`**: Updated for Fly.io PostgreSQL
- **`bin/fly_setup`**: Automated setup script
- **`bin/fly_deploy`**: Deployment script

## Environment Variables

The app uses these environment variables in production:

- `DATABASE_URL`: Automatically set by Fly.io PostgreSQL
- `SECRET_KEY_BASE`: Rails secret key
- `RAILS_ENV`: Set to `production`
- `RAILS_SERVE_STATIC_FILES`: Enables serving static files
- `RAILS_LOG_TO_STDOUT`: Enables logging to stdout

## Useful Commands

### View application logs
```bash
fly logs --app cards
```

### SSH into your application
```bash
fly ssh console --app cards
```

### Check application status
```bash
fly status --app cards
```

### Open your deployed app
```bash
fly open --app cards
```

### Scale your application
```bash
fly scale count 2 --app cards
```

### Run Rails console in production
```bash
fly ssh console --app cards
# Then inside the container:
cd /rails && bundle exec rails console
```

### Run database migrations
```bash
fly ssh console --app cards
# Then inside the container:
cd /rails && bundle exec rails db:migrate
```

## Domains and SSL

Fly.io automatically provides:
- SSL certificates
- A `.fly.dev` subdomain
- Custom domain support (see Fly.io docs)

Your app will be available at: `https://cards.fly.dev`

## Database Management

### Connect to PostgreSQL directly
```bash
fly postgres connect --app cards-db
```

### Create database backups
```bash
fly postgres backup list --app cards-db
```

## Troubleshooting

### Check build logs
```bash
fly logs --app cards
```

### Restart the application
```bash
fly apps restart cards
```

### Check resource usage
```bash
fly status --app cards
```

### Debug deployment issues
```bash
fly doctor --app cards
```

## Scaling and Performance

### Vertical scaling (more CPU/memory)
```bash
fly scale vm shared-cpu-2x --app cards
```

### Horizontal scaling (more instances)
```bash
fly scale count 2 --app cards
```

### Monitor performance
```bash
fly dashboard cards
```

## Cost Optimization

- Fly.io offers generous free tier limits
- Apps automatically suspend when not in use
- Monitor usage in the Fly.io dashboard
- Consider scaling down during low-traffic periods

## Security

- All traffic is encrypted with SSL
- Database connections are encrypted
- Environment variables are securely stored
- Regular security updates via new deployments
