#!/bin/bash

# Load environment variables from the specified file
source=../notesnook.env

required_vars=(
  'INSTANCE_NAME'
  'NOTESNOOK_API_SECRET'
  'DISABLE_SIGNUPS'
  'SMTP_USERNAME'
  'SMTP_PASSWORD'
  'SMTP_HOST'
  'SMTP_PORT'
  'AUTH_SERVER_PUBLIC_URL'
  'NOTESNOOK_APP_PUBLIC_URL'
  'MONOGRAPH_PUBLIC_URL'
  'ATTACHMENTS_SERVER_PUBLIC_URL'
  )

for var in "${required_vars[@]}"; do
  if [ -z "${!var}" ]; then
    echo "Error: Required environment variable ${var} is not set in notesnook.env."
    exit 1
  fi
done

echo "All required environment variables are set."
