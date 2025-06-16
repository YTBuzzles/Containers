#!/bin/bash

# Wait for MinIO to become available (improved loop)
while ! mc alias list | grep minio; do  # Check if alias exists
  mc alias set minio http://notesnook-s3:9000 "${MINIO_ROOT_USER:-minioadmin}" "${MINIO_ROOT_PASSWORD:-minioadmin}"
  if [[ $? -eq 0 ]]; then # Check if the alias command was successful.
    echo "MinIO alias set successfully."
    break  # Exit the loop if alias set correctly
  else
    echo "Trying to set MinIO alias..."
    sleep 1
  fi
done

# Create the bucket (only if it doesn't exist)
if ! mc ls minio/attachments; then # Check if the bucket exists
  mc mb minio/attachments -p
  if [[ $? -eq 0 ]]; then # Check if the bucket creation command was successful.
    echo "Attachments bucket created successfully."
  else
    echo "Error creating attachments bucket."
    exit 1
  fi
else
  echo "Attachments bucket already exists."
fi

# Any other setup commands can go here

exec "$@" # Execute the original command passed by the container.
