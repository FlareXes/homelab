#!/bin/bash
set -e

# Function to start a specific container
up_container() {
    local container_name=$1
    docker-compose -f "$container_name/docker-compose.yml" up -d
}

# Function to stop a specific container
down_container() {
    local container_name=$1
    docker-compose -f "$container_name/docker-compose.yml" down
}

# Function to add a hostname entry to /etc/hosts if it doesn't exist
add_to_hosts() {
    local hostname_entry=$1
    if ! grep -qxF "$hostname_entry" /etc/hosts; then
        echo "[+] Adding '$hostname_entry' to /etc/hosts..."
        echo "$hostname_entry" | sudo tee -a /etc/hosts >/dev/null
    fi
}

# Create a homelab_caddy docker network if it doesn't exist
if ! docker network inspect homelab_caddy >/dev/null 2>&1; then
    echo "Creating Docker network homelab_caddy..."
    docker network create homelab_caddy
fi

# Check the command provided
if [[ $1 == "up" ]]; then
    # Start specific containers
    up_container "caddy"
    up_container "ollama"
    up_container "portainer"
    up_container "whoogle"

    # Update /etc/hosts if entry does not exist
    add_to_hosts "127.0.0.1  ollama.homelab.local"
    add_to_hosts "127.0.0.1  webui.homelab.local"
    add_to_hosts "127.0.0.1  portainer.homelab.local"
    add_to_hosts "127.0.0.1  google.homelab.local"
    add_to_hosts "127.0.0.1  homelab.local"

elif [[ $1 == "down" ]]; then
    # Stop specific containers
    down_container "caddy"
    down_container "ollama"
    down_container "portainer"
    down_container "whoogle"

else
    echo "Usage: $0 [up|down]"
    exit 1
fi
