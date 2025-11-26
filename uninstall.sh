#!/usr/bin/env bash
# uninstall.sh - uninstall smtty
#
# Defaults to user uninstall from: $HOME/.local/bin/smtty
# Override with: PREFIX=/some/prefix ./uninstall.sh
#   -> removes: $PREFIX/bin/smtty

set -euo pipefail

PREFIX=${PREFIX:-"$HOME/.local"}
BINDIR="$PREFIX/bin"
TARGET="$BINDIR/smtty"

if [[ ! -e "$TARGET" ]]; then
  echo "smtty not found at $TARGET"
  # If some other smtty is on PATH, tell user where
  if command -v smtty >/dev/null 2>&1; then
    echo "smtty is currently resolved to: $(command -v smtty)"
    echo "Run uninstall.sh with PREFIX matching that path if needed."
  fi
  exit 0
fi

echo "This will remove smtty from: $TARGET"
read -rp "Proceed? [y/N]: " ans
case "$ans" in
  [yY])
    rm -f "$TARGET"
    echo "Removed smtty from $TARGET"
    ;;
  *)
    echo "Aborted."
    exit 1
    ;;
esac

if [[ -d "$HOME/.config/smtty" ]]; then
  echo
  echo "A config directory exists at: $HOME/.config/smtty"
  read -rp "Remove config directory as well? [y/N]: " c
  case "$c" in
    [yY]) rm -rf "$HOME/.config/smtty"; echo "Config removed.";;
    *)    echo "Config kept.";;
  esac
fi
