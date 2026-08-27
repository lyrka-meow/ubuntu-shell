# Ubuntu Shell

A persistent Ubuntu Server-like shell running in a Docker container.

## Install on Arch Linux

Download the latest `ubuntu-shell-*.pkg.tar.zst` file from
[GitHub Releases](https://github.com/lyrka-meow/ubuntu-shell/releases), then
install it with pacman:

```bash
sudo pacman -U ./ubuntu-shell-1.0.6-1-x86_64.pkg.tar.zst
```

Open the Ubuntu shell:

```bash
ubuntu-shell
```

Docker and the Docker Compose plugin are installed automatically as package
dependencies. On first launch, Ubuntu Shell starts Docker and grants the current
user access; this may ask for the sudo password. It works immediately in a
temporary Docker group session, and later login sessions inherit that access
normally. The first launch also builds the Ubuntu image and can take a few
minutes. Build progress is shown in the terminal. Later launches reuse Docker's
build cache.

## Commands

```text
ubuntu-shell          Start the container and open the Ubuntu shell
ubuntu-shell start    Start or update the container
ubuntu-shell status   Show the container status
ubuntu-shell stop     Stop the container and preserve its data
ubuntu-shell clean    Remove the container, image and persistent home volume
ubuntu-shell help     Show command help
```

The shell opens in `/home/ubuntu`. This directory is stored in a Docker volume,
so files there survive container recreation, package updates and package
removal. Running `ubuntu-shell clean` deletes that persistent data.

Inside the container, use `sudo` when root access is required:

```bash
sudo apt update
sudo apt install htop
```

## Uninstall

To remove the container, image and persistent data first:

```bash
ubuntu-shell clean
```

Remove the Arch package:

```bash
sudo pacman -Rns ubuntu-shell
```

Omit `ubuntu-shell clean` if you want the persistent Docker volume to remain
available for a later reinstall.

## Build the Arch package

Release packages are built automatically when a tag such as `v1.0.6` is
pushed. To build the package manually from a tagged checkout:

```bash
cd packaging/arch
makepkg --syncdeps --cleanbuild
```

The resulting file is named like
`ubuntu-shell-1.0.6-1-x86_64.pkg.tar.zst`.

## Run from source

```bash
git clone https://github.com/lyrka-meow/ubuntu-shell.git
cd ubuntu-shell
make shell
```

The legacy curl installer remains available for existing installations:

```bash
curl -fsSL https://raw.githubusercontent.com/lyrka-meow/ubuntu-shell/main/installer/install.sh | bash
```

Use `installer/uninstall.sh` to remove a legacy installation.
