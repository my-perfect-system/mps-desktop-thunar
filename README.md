# mps-desktop-thunar

Thunar file manager configuration of the my-perfect-system (mps) desktop stack.

## Install

| Method | Description |
|---|---|
| Default | `bootstrap.sh` clones to the system-wide mps repo dir and runs `install.sh` |
| Ansible | can be used by installing via the `odem.desktop.thunar` role of [odem-desktop](https://github.com/my-perfect-system-ansible/odem-desktop) |
| Standalone | clone the repo, then run `./install.sh` inside it |

### Install (Default)

```bash
curl -fsSL https://raw.githubusercontent.com/my-perfect-system/mps-desktop-thunar/main/bootstrap.sh | bash
```

All methods install thunar + plugins best-effort (`MPS_THUNAR_ENABLE_PACKAGES=0`
to skip, `MPS_THUNAR_ENABLE_XFCE=0` for the xfce4 helpers) and deploy the config
to the current user's `~/.config`; one clone per host
(`${MPS_REPO_DIR:-/srv/repo/github/my-perfect-system/mps}`), shared by all users.

## Usage

```bash
thunar                            # file manager
info-custom-actions              # alias: list custom actions (from odem bash aliases)
```

## Layout

| Path | Deploy target |
|---|---|
| `config/Thunar/` | `~/.config/Thunar/` (accels, custom actions) |
| `config/xfce4/` | `~/.config/xfce4/` (xfconf per-channel XML) |