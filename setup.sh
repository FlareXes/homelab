#!/bin/bash
set -e

# Create a homelab_caddy docker network if it doesn't exist
if ! docker network inspect homelab_caddy >/dev/null 2>&1; then
    echo "Creating Docker network homelab_caddy..."
    docker network create homelab_caddy
fi

if [[ $1 == "up" ]]; then
    for file in $(find . -type f -name 'docker-compose.yml'); do
        echo "Starting containers in $file..."
        docker-compose -f "$file" up -d
    done

    # Update /etc/hosts if entry does not exist
    grep -qxF "127.0.0.1  ollama.homelab.local" /etc/hosts || sudo sh -c 'echo "127.0.0.1  ollama.homelab.local" >> /etc/hosts'
    grep -qxF "127.0.0.1  portainer.homelab.local" /etc/hosts || sudo sh -c 'echo "127.0.0.1  portainer.homelab.local" >> /etc/hosts'
    grep -qxF "127.0.0.1  google.homelab.local" /etc/hosts || sudo sh -c 'echo "127.0.0.1  google.homelab.local" >> /etc/hosts'
elif [[ $1 == "down" ]]; then
    for file in $(find . -type f -name 'docker-compose.yml'); do
        echo "Stopping containers in $file..."
        docker-compose -f "$file" down
    done
else
    echo "Usage: $0 [up|down]"
    exit 1
fi
