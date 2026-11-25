#!/usr/bin/env bash
# Fedora/RHEL system packages for mps-desktop-thunar. Best-effort, sourced
# from install.sh; can also be run directly.
set -euo pipefail

SUDO=""
[[ ${EUID} -eq 0 ]] || SUDO="sudo"

# Toggles (defaults mirror the odem.desktop.thunar role)
ENABLE_PACKAGES="${MPS_THUNAR_ENABLE_PACKAGES:-1}"
ENABLE_XFCE="${MPS_THUNAR_ENABLE_XFCE:-1}"

if [[ "${ENABLE_PACKAGES}" = 1 ]]; then
    ${SUDO} dnf install -y thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman
fi

if [[ "${ENABLE_XFCE}" = 1 ]]; then
    ${SUDO} dnf install -y thunar-archive-plugin thunar-media-tags-plugin \
        || echo "==> WARN: xfce support packages not available on this Fedora release"
fi

echo "mps-desktop-thunar Fedora packages installed"