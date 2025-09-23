#!/bin/sh

# Exit on error
set -e

# Check if homeserver.yaml already exists
if [ -f "/data/homeserver.yaml" ]; then
    echo "homeserver.yaml already exists, skipping generation."
    exit 0
fi

# Check if SYNAPSE_SERVER_NAME is set
if [ -z "$SYNAPSE_SERVER_NAME" ]; then
    echo "SYNAPSE_SERVER_NAME is not set. Please set it in your .env file."
    exit 1
fi

# Generate the homeserver.yaml
/start.py generate

# Update the database configuration
sed -i "s/name: sqlite3/name: psycopg2/g" /data/homeserver.yaml
sed -i "s|database: /data/homeserver.db|database: postgres\n    user: postgres\n    password: ${POSTGRES_PASSWORD}\n    host: postgres|g" /data/homeserver.yaml

# Enable registration
sed -i "s/enable_registration: false/enable_registration: true/g" /data/homeserver.yaml
