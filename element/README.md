# Element Web Docker Compose Setup

This directory contains the necessary files to run an Element Web client using Docker Compose.

## Prerequisites

- Docker and Docker Compose must be installed.
- You must have a running Matrix homeserver (e.g., Synapse) that is accessible from the same Docker network.

## Setup

1.  **Create the shared network:**

    The Element service connects to a shared Docker network named `n1-shared-network`. If you haven't already, create this network by running:

    ```bash
    docker network create n1-shared-network
    ```

2.  **Configure Element:**

    The `config/config.json` file is configured to connect to a homeserver with the container name `synapse` on the `n1-shared-network`. If your homeserver has a different name or address, you will need to update this file accordingly.

    Specifically, you should modify the `base_url` and `server_name` under `m.homeserver`. For example:

    ```json
    "m.homeserver": {
        "base_url": "https://your-homeserver-url",
        "server_name": "your-homeserver-name"
    }
    ```

3.  **Set up environment variables:**

    Create a `.env` file in the root of the project (or copy `.env.element.example` to `.env`) and set the `ELEMENT_HOSTNAME` variable. This will determine the URL where Element will be accessible.

    ```
    ELEMENT_HOSTNAME=element.your-domain.com
    ```

## Running the Service

To run the Element service, you can use the main `docker-compose.yml` file from the root of the project:

```bash
docker-compose up -d
```

This will start the Element Web client, along with any other services defined in the main Docker Compose file. You can then access Element at the hostname you configured.
