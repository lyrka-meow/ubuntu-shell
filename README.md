# Ubuntu Shell

A persistent Ubuntu Server-like shell running in a Docker container.

## Requirements

- Docker
- Docker Compose plugin

On Arch Linux:

```bash
sudo pacman -S docker docker-compose
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"
```

Log out and back in after adding yourself to the `docker` group.

## Start and connect

```bash
git clone https://github.com/lyrka-meow/ubuntu-shell.git
cd ubuntu-shell
make shell
```

Or without `make`:

```bash
docker compose up -d --build
docker compose exec ubuntu bash
```

The container runs as the `ubuntu` user. Use `sudo` when root access is
required:

```bash
sudo apt update
sudo apt install htop
```

The repository is mounted at `/workspace`. The `/home/ubuntu` directory is
stored in a Docker volume, so files there survive container recreation.

## Commands

```bash
make shell  # start the container and open Bash
make stop   # stop the container
make clean  # stop it and delete the persistent home volume
```
