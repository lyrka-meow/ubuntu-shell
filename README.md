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

### One-command installation on Arch Linux

```bash
curl -fsSL https://raw.githubusercontent.com/lyrka-meow/ubuntu-shell/main/installer/install.sh | bash
```

After installation, open the Ubuntu shell with:

```bash
ubuntu-shell
```

If the installer adds you to the `docker` group, log out and back in once
before running the command.

### Manual installation

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

The shell opens in `/home/ubuntu`. This directory is stored in a Docker volume,
so files there survive container recreation.

## Commands

```bash
make shell  # start the container and open Bash
make stop   # stop the container
make clean  # stop it and delete the persistent home volume
```

## Uninstall

Remove Ubuntu Shell, its image and persistent data while keeping Docker:

```bash
curl -fsSL https://raw.githubusercontent.com/lyrka-meow/ubuntu-shell/main/installer/uninstall.sh | bash
```

To remove Docker as well:

```bash
curl -fsSL https://raw.githubusercontent.com/lyrka-meow/ubuntu-shell/main/installer/uninstall.sh | bash -s -- --remove-docker
```
