# Homelab

This repository contains scripts and configurations for managing a homelab
environment using Docker and Docker Compose. It includes setups for Caddy web
server and other services.

## Project Structure

```
.
├── caddy
│   ├── Caddyfile
│   ├── cmds.md
│   ├── docker-compose.yml
│   └── site
├── LICENSE
├── ollama
│   └── docker-compose.yml
├── README.md
└── setup.sh
```

- **caddy**: Contains configurations for the Caddy web server, including its
  `Caddyfile`, additional commands documentation (`cmds.md`), and the Docker
  Compose configuration file.
- **ollama**: Docker Compose configuration for the Ollama service.
- **setup.sh**: Bash script for setting up and managing the Docker environment.

## Usage

### Setup

Before running any services, ensure Docker is installed and running on your
system. Then execute the setup script:

```bash
sudo ./setup.sh up
```

This script will create a Docker network named `homelab_caddy` if it doesn't
exist already. It will then start containers defined in all `docker-compose.yml`
files found in the repository.

### Tear Down

To stop and remove all containers:

```bash
sudo ./setup.sh down
```

### Additional Configuration

The setup script also updates the `/etc/hosts` file to include necessary entries
for local development. You can manually modify this file if needed.

## Issues

If you encounter any issues or have suggestions for improvements, please open an
issue on the [GitHub repository](https://github.com/flarexes/homelab/issues).

## Contributors

Feel free to contribute to this project by submitting pull requests or opening
issues.

## License

This project is licensed under the terms of the [MIT](LICENSE) LICENSE.
