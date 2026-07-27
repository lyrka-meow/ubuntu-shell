#!/usr/bin/env bash
set -Eeuo pipefail

REPOSITORY_URL="https://github.com/lyrka-meow/ubuntu-shell.git"
INSTALL_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/ubuntu-shell"
COMMAND_PATH="/usr/local/bin/ubuntu-shell"
OLD_COMMAND_PATH="${HOME}/.local/bin/ubuntu-shell"

if [[ ! -r /etc/os-release ]]; then
  echo "Cannot detect the operating system." >&2
  exit 1
fi

# shellcheck disable=SC1091
source /etc/os-release
if [[ "${ID_LIKE:-} ${ID:-}" != *arch* ]]; then
  echo "This installer currently supports Arch Linux and Arch-based systems." >&2
  exit 1
fi

if ! command -v git >/dev/null; then
  sudo pacman -S --needed --noconfirm git
fi

if ! command -v docker >/dev/null; then
  sudo pacman -S --needed --noconfirm docker docker-compose
fi

sudo systemctl enable --now docker

if [[ -d "$INSTALL_DIR/.git" ]]; then
  git -C "$INSTALL_DIR" pull --ff-only
elif [[ -e "$INSTALL_DIR" ]]; then
  echo "$INSTALL_DIR already exists and is not a Git repository." >&2
  exit 1
else
  git clone "$REPOSITORY_URL" "$INSTALL_DIR"
fi

sudo ln -sfn "$INSTALL_DIR/installer/ubuntu-shell" "$COMMAND_PATH"
if [[ -L "$OLD_COMMAND_PATH" ]]; then
  unlink "$OLD_COMMAND_PATH"
fi

if ! id -nG | tr ' ' '\n' | grep -qx docker; then
  sudo usermod -aG docker "$USER"
  echo
  echo "Docker group access was enabled."
  echo "Log out and back in, then run: ubuntu-shell"
else
  docker compose -f "$INSTALL_DIR/compose.yaml" up -d --build
  echo
  echo "Installed successfully. Run: ubuntu-shell"
fi
