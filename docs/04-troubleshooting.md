# 04 — Troubleshooting journal

Problems actually encountered while bringing up Debian ARM64 in UTM. These are diagnostics and observed fixes, not proof that every underlying cause has been established.

## VM displays “Display output is not active” after `sudo reboot`

**Observed:** On some warm boots, UTM showed GRUB and then stopped presenting a graphical signal; shutting down the VM and starting it from UTM usually worked. At other times the display appeared after waiting. Root cause **unconfirmed**.

**Safe first steps:** wait a minute or two; avoid repeated force-stops; if possible inspect the serial console or guest logs to distinguish a display issue from a kernel boot failure. With the guest safely stopped, verify UTM display card and graphics settings. We used `virtio-gpu-pci`, no experimental OpenGL, Auto Resolution enabled. A mouse Xorg input config has no demonstrated causal connection to the warm-reboot issue.

## UTM fullscreen is blurry or has tiny text

**Cause observed:** Guest was initially rendering at `1280x800` and the window scaled the low-resolution image. Running a higher `xrandr` mode made it sharper. Later, automatic resizing via SPICE set a near-native guest resolution (`2560x1369` in the available fullscreen area).

**Check:**

```bash
xrandr | head -n 2
```

**Preferred:** enable UTM Auto Resolution, install `spice-vdagent`, and reboot. The guest can then render at the actual VM-window dimensions rather than stretching a fixed image. Do not use a fixed `xrandr` startup command after this works. Adjust Alacritty font size separately; the i3 bar has its own font setting.

[UTM dynamic-resolution guide](https://docs.getutm.app/guest-support/dynamic-resolution/)

## Clipboard between macOS and Debian fails

1. Confirm clipboard sharing is enabled in UTM's VM settings.
2. Install `sudo apt install spice-vdagent` in Debian.
3. Confirm SPICE channel exists (`ls -l /dev/virtio-ports/`, looking for `com.redhat.spice.0`).
4. Check user agent (`pgrep -a spice-vdagent`).
5. Restart the Linux guest so session and system components initialize together. This is what finally resolved our initial clipboard and resizing problem.
6. Test text in both directions. For Alacritty, use `Ctrl+Shift+V` to paste; normal GUI shortcuts differ from macOS.

`spice-vdagentd.service` may be socket-activated. Earlier manual attempts to enable a static socket reported errors. **Do not treat `inactive` alone as a diagnosis or routinely force-enable units.**

[UTM clipboard instructions](https://docs.getutm.app/guest-support/sharing/clipboard/)

## Mouse scroll is reversed

`xinput list` showed multiple virtual pointers. Changing the QEMU USB Mouse did not affect scrolling; enabling natural scrolling on **`spice vdagent tablet`** did.

Temporary test:

```bash
xinput list --name-only
xinput set-prop 'spice vdagent tablet' 'libinput Natural Scrolling Enabled' 1
```

Persistent Xorg configuration: `config/x11/40-zen-mouse.conf`; see the [Debian guide](02-debian-foundation.md). After a reboot, value `1` was observed and scrolling behaved as expected.

## `Super+Shift+Q` is intercepted by macOS

UTM doesn't necessarily forward every macOS Command shortcut. Some i3 bindings may use different modifiers; compare your *running* i3 bindings with `~/.config/i3/config` before editing. `exit` in a terminal closes its shell/window safely. We have **not yet finished standardizing all keyboard shortcuts**.

## Git push rejected: GH007 private email

GitHub blocked a commit with a private author email. See [Git/SSH guide](03-git-github-ssh.md). Prefer GitHub's noreply author address; account-setting changes don't automatically rewrite already committed metadata.

## What to record with new problems

- Exact error message and when it happens (cold start, warm reboot, login, fullscreen)
- Relevant command and output
- VM display settings and `xrandr` current resolution
- Whether solution was tested again after logout/reboot
- Temporary workaround vs confirmed permanent fix
