#!/usr/bin/env bash
# Debian/Ubuntu system packages for mps-desktop-thunar. Best-effort, sourced
# from install.sh; can also be run directly.
set -euo pipefail

SUDO=""
[[ ${EUID} -eq 0 ]] || SUDO="sudo"

# Toggles (defaults mirror the odem.desktop.thunar role)
ENABLE_PACKAGES="${MPS_THUNAR_ENABLE_PACKAGES:-1}"
ENABLE_XFCE="${MPS_THUNAR_ENABLE_XFCE:-1}"

if [[ "${ENABLE_PACKAGES}" = 1 ]]; then
    ${SUDO} apt-get install -y thunar thunar-archive-plugin thunar-media-tags-plugin \
        thunar-volman thunar-gtkhash thunarx-python
fi

if [[ "${ENABLE_XFCE}" = 1 ]]; then
    ${SUDO} apt-get install -y xfce4-goodies xfce4-places-plugin thunar-font-manager
fi

echo "mps-desktop-thunar Debian packages installed"