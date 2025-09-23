# Element Web Docker Compose Setup

This directory contains the files to run an Element Web client using Docker Compose.

## Prerequisites

- Docker and Docker Compose must be installed.
- You must have a running Matrix homeserver (like the one in the `../synapse` directory).

## Setup

1.  **Configure Element:**

    The `config/config.json` file is configured by default to connect to a homeserver at `https://synapse.localhost`. If you configured your Synapse server with a different `server_name`, you must update the `default_server_config` section in `config/config.json` to match it. Both the `base_url` and `server_name` should reflect the public address of your Synapse homeserver.

2.  **Set up environment variables:**

    Create a `.env` file in the root of the project (you can copy `.env.matrix.example`) and set the `ELEMENT_HOSTNAME` variable. This will determine the URL where the Element client will be accessible.

    ```
    ELEMENT_HOSTNAME=element.your-domain.com
    ```

## Running the Service

To run the Element service, use the main `docker-compose.yml` file from the root of the project:

```bash
docker-compose up -d
```

This will start the Element Web client. You can then access it at the hostname you configured.
