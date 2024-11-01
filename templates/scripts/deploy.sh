#!/bin/bash

APP_DIR="/var/www/html/partneraXap1"

# Function to log messages
log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1"
}

log "Starting deployment..."

log "Navigating to application directory..."
if ! cd "$APP_DIR"; then
  log "Failed to navigate to $APP_DIR"
  exit 1
fi

log "Updating Composer dependencies..."
if ! composer install --no-dev --optimize-autoloader; then
  log "Composer install failed"
  exit 1
fi

log "Running database migrations..."
if ! php artisan migrate --force; then
  log "Migration failed"
  exit 1
fi

log "Running database seeders..."
if ! php artisan db:seed --force; then
  log "Seeding failed"
  exit 1
fi

log "Clearing application caches..."
if ! php artisan cache:clear; then
  log "Cache clear failed"
  exit 1
fi

if ! php artisan config:clear; then
  log "Config clear failed"
  exit 1
fi

if ! php artisan route:clear; then
  log "Route clear failed"
  exit 1
fi

if ! php artisan view:clear; then
  log "View clear failed"
  exit 1
fi

log "Deployment commands executed successfully."
