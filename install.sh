#!/usr/bin/env bash
# Deploy mps-desktop-thunar to the current user's ~/.config. Idempotent.
# OS-specific packages live in install-debian.sh / install-fedora.sh and are
# installed best-effort before the config deploy.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#--- Distro detection -----------------------------------------------------------
detect_distro() {
    local id
    id="$(grep -sE '^ID=' /etc/os-release | head -1 | cut -d= -f2 | tr -d '\"')"
    case "${id}" in
        debian|ubuntu) echo "debian" ;;
        fedora|rhel)   echo "fedora" ;;
        *)
            if command -v apt-get >/dev/null 2>&1; then echo "debian"
            elif command -v dnf >/dev/null 2>&1; then echo "fedora"
            else echo "none"; fi ;;
    esac
}

#--- System: distro packages (best-effort) --------------------------------------
case "$(detect_distro)" in
    debian) "${SRC}/install-debian.sh" || echo "==> WARN: install-debian.sh failed; continuing" ;;
    fedora)  "${SRC}/install-fedora.sh" || echo "==> WARN: install-fedora.sh failed; continuing" ;;
    *)       echo "==> Unsupported distro — skipping system packages" ;;
esac

#--- Per-user: config deploy (overwrite; mirrors the odem.desktop.thunar role) -
install -d -m 0700 "${HOME}/.config"
cp -a "${SRC}/config/Thunar/." "${HOME}/.config/Thunar/" 2>/dev/null || {
    install -d -m 0700 "${HOME}/.config/Thunar"
    cp -a "${SRC}/config/Thunar/." "${HOME}/.config/Thunar/"
}
cp -a "${SRC}/config/xfce4/." "${HOME}/.config/xfce4/" 2>/dev/null || {
    install -d -m 0700 "${HOME}/.config/xfce4"
    cp -a "${SRC}/config/xfce4/." "${HOME}/.config/xfce4/"
}

echo "mps-desktop-thunar deployed to ${HOME}/.config/{Thunar,xfce4}."