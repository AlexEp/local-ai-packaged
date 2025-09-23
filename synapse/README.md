# Synapse Homeserver Docker Compose Setup

This directory contains the files to run a Synapse Matrix homeserver using Docker Compose.

## Prerequisites

- Docker and Docker Compose must be installed.
- You must have created the shared network `n1-shared-network`. If not, run `docker network create n1-shared-network`.

## Setup

The Synapse homeserver requires a `homeserver.yaml` configuration file to run. You must generate this file before starting the service.

### 1. Create a data directory

The generation command will write the configuration into a directory. Create it first:
```bash
mkdir data
```

### 2. Set up environment variables

The services rely on environment variables. Copy the `../../.env.matrix.example` to `../../.env` and fill in the values for `SYNAPSE_DB_USER`, `SYNAPSE_DB_PASSWORD`, and `SYNAPSE_DB_NAME`.

### 3. Generate `homeserver.yaml`

Run the following command from the root of this project. This command will mount the `synapse/data` directory you just created and generate the `homeserver.yaml` file inside it.

**Important:** Replace `synapse.your-domain.com` with the public-facing domain name for your Synapse server. This **must** match the `SYNAPSE_HOSTNAME` you set in your `.env` file. For a local setup, you can use `synapse.localhost`.

```bash
docker run -it --rm \
    -v $(pwd)/synapse/data:/data \
    -e SYNAPSE_SERVER_NAME=synapse.your-domain.com \
    -e SYNAPSE_REPORT_STATS=yes \
    matrixdotorg/synapse:latest generate
```

This will create the `homeserver.yaml` file in `synapse/data`.

### 4. Configure `homeserver.yaml` for PostgreSQL

After generating the file, you need to edit `synapse/data/homeserver.yaml` to configure it to use the PostgreSQL database.

Find the `database:` section in the file and replace the `name: sqlite3` configuration with the following, making sure to use the same credentials you set in your `.env` file.

```yaml
database:
  name: psycopg2
  args:
    user: YOUR_SYNAPSE_DB_USER
    password: YOUR_SYNAPSE_DB_PASSWORD
    database: YOUR_SYNAPSE_DB_NAME
    host: synapse-db
    cp_min: 5
    cp_max: 10
```

### 5. Running the Service

Once the `homeserver.yaml` is generated and configured, you can start the service using the main `docker-compose.yml` from the root of the project:
```bash
docker-compose up -d
```
This will start the Synapse homeserver and its database.
