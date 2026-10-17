# 02 — Minimal Debian foundation (hardware-independent)

**For:** A fresh Debian installation, in UTM or on another machine. UTM-specific steps are explicitly labeled.

This is a small X11/i3 environment, not a GNOME or KDE installation. Commands marked **inspect** do not modify the system.

## 1. Update package metadata

```bash
sudo apt update
```

`apt update` refreshes available package metadata; it does not upgrade installed software. For a larger upgrade, separately review `sudo apt upgrade` or `sudo apt full-upgrade`.

## 2. Install the graphical desktop

```bash
sudo apt install xorg i3-wm i3status lightdm alacritty
```

If asked for a display manager, select **LightDM**. Reboot (`sudo reboot`) and log in. At the i3 first-start prompt, generate the default config and select **Win/Super** for the main modifier. On our UTM/Mac setup, Command mapped to Super, but keyboard mappings can differ.

- **Super+Enter:** terminal
- **Super+Left/Right:** change focused window
- **Super+Shift+Q:** commonly kills a window, but macOS can intercept some shortcuts; use `exit` inside a shell as a fallback.

## 3. Install core utilities

```bash
sudo apt install git xinput
```

`git` is version control. `xinput` helps inspect X11 pointing devices.

For the exact intentional package list, see [`../packages/debian.txt`](../packages/debian.txt). The list is deliberately curated, not a complete snapshot of Debian's install dependencies.

## 4. UTM guests only: clipboard and auto resolution

```bash
sudo apt install spice-vdagent
```

**Restart the guest** after installing the agent; in our initial i3 session clipboard sync and dynamic resolution only began working reliably after a restart. Verify in UTM that clipboard sharing and Auto Resolution are enabled.

Useful checks:

```bash
pgrep -a spice-vdagent
ls -l /dev/virtio-ports/
xrandr | head -n 2
```

`/dev/virtio-ports/com.redhat.spice.0` should exist when UTM exposes the SPICE channel. The agent service/socket may be socket-activated; an `inactive` service status alone does **not** prove a failure. Avoid permanently hardcoding a monitor resolution once dynamic resizing works.

## 5. Natural scrolling on the UTM virtual pointer

**UTM-specific:** We identified the device using `xinput list --name-only` as `spice vdagent tablet`. The working permanent config is tracked at [`../config/x11/40-zen-mouse.conf`](../config/x11/40-zen-mouse.conf).

On a new Debian VM, copy it into Xorg's configuration directory:

```bash
sudo mkdir -p /etc/X11/xorg.conf.d
sudo cp config/x11/40-zen-mouse.conf /etc/X11/xorg.conf.d/
```

Run the copy from the repository root and only if the device name/driver match. If you already have a file at that path, back it up first. Restart the graphical session and verify:

```bash
xinput list-props 'spice vdagent tablet' | grep 'Natural Scrolling Enabled ('
```

A value of `1` indicates natural scrolling is on. Physical Linux hardware may need a different `MatchProduct` or configuration approach.

## 6. Inspect manually installed packages

```bash
apt-mark showmanual | sort
cat /var/log/apt/history.log
```

`apt-mark showmanual` is the closest built-in approximation to `brew leaves`, **but it also includes some installer-selected system packages**. Maintain the curated package manifest instead of blindly replaying everything marked manual.

## 7. Restore tracked i3 settings (later, carefully)

The initial personal i3 configuration was copied from `/etc/i3/config` to `~/.config/i3/config`, then version-controlled. On a fresh system, first compare the checked-in file to the generated/system version. Back up anything at the destination before copying. No automated overwrite is provided yet.

## 8. Next guides

- [03 — Git and GitHub via SSH](03-git-github-ssh.md)
- [04 — Troubleshooting](04-troubleshooting.md)
