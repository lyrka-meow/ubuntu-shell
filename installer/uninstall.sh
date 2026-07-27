#!/usr/bin/env bash
set -Eeuo pipefail

INSTALL_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/ubuntu-shell"
COMMAND_PATH="/usr/local/bin/ubuntu-shell"
OLD_COMMAND_PATH="${HOME}/.local/bin/ubuntu-shell"

if [[ -f "$INSTALL_DIR/compose.yaml" ]] && command -v docker >/dev/null; then
  docker compose -f "$INSTALL_DIR/compose.yaml" down --volumes --rmi local || true
fi

if [[ -L "$COMMAND_PATH" ]]; then
  sudo unlink "$COMMAND_PATH"
fi

if [[ -L "$OLD_COMMAND_PATH" ]]; then
  unlink "$OLD_COMMAND_PATH"
fi

if [[ -d "$INSTALL_DIR" ]]; then
  rm -rf -- "$INSTALL_DIR"
fi

echo "Ubuntu Shell and its persistent data were removed."

if [[ "${1:-}" == "--remove-docker" ]]; then
  sudo pacman -Rns docker docker-compose
  echo "Docker was removed too."
else
  echo "Docker was left installed."
fi
