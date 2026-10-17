# Zen Linux

*A lightweight, keyboard-first Linux workspace with switchable visual profiles.*

Zen Linux is a reproducible Debian-based desktop built for coding, reading, writing, and terminal-first workflows. The primary environment runs in a UTM virtual machine on Apple Silicon, but most Debian configuration is host-independent.

> **Project status:** Foundation installed. Aesthetic profiles (starting with **Sakura Dusk**, plus a deliberately spare **Tsoding-inspired** profile) are planned, not yet implemented.

## Start here

| Your starting point | Guide |
| --- | --- |
| I have an Apple Silicon Mac and no VM | [Install Debian with UTM](docs/01-macos-utm.md) |
| Debian is already installed | [Configure minimal Debian + i3](docs/02-debian-foundation.md) |
| Desktop works; I want GitHub push/pull | [Git and SSH](docs/03-git-github-ssh.md) |
| Something isn't working | [Troubleshooting](docs/04-troubleshooting.md) |

## Current stack

- Debian 13 ARM64; i3 (X11); Alacritty; LightDM
- UTM, QEMU backend (when running on macOS)
- SPICE guest agent for macOS ↔ Linux clipboard and dynamic display resizing
- Git via SSH; a device-specific X11 natural-scrolling configuration

## Design principles

1. **Keyboard-first:** predictable shortcuts and no mandatory mouse-heavy workflow.
2. **Minimal core, expressive profiles:** one foundation; different visual experiences.
3. **Reproducible:** store configuration, package choices, and clear setup steps in Git.
4. **Understandable:** explain each command instead of hiding everything behind one installer.
5. **Secure:** no passwords, tokens, private SSH keys, or personal data in Git.

## Repository layout (planned)

```text
zen-linux/
├── README.md
├── docs/
│   ├── 01-macos-utm.md
│   ├── 02-debian-foundation.md
│   ├── 03-git-github-ssh.md
│   └── 04-troubleshooting.md
├── packages/
│   └── debian.txt
├── config/
│   ├── i3/config
│   └── x11/40-zen-mouse.conf
├── profiles/
│   ├── sakura-dusk/
│   └── tsoding/
├── scripts/
└── assets/wallpapers/
```

The profile directories, wallpaper collection, and automation are future work. Empty directories aren't tracked by Git.

## Restore philosophy

On a new Debian installation, follow [the foundation guide](docs/02-debian-foundation.md) and then clone this repository. **Do not overwrite an existing config without first backing it up.** Some steps use `sudo` because they install packages or system-wide configuration.

## Security and assets

Never commit `~/.ssh/id_ed25519`, `.env` files, API credentials, browser profiles, password databases, or private documents. Wallpapers and fonts need attribution and redistribution-rights checks before adding to a public repository. Large wallpaper assets may be hosted outside regular Git later.

## References

- [UTM](https://mac.getutm.app/)
- [Debian installer](https://www.debian.org/releases/stable/debian-installer/)
- [UTM Linux guest support](https://docs.getutm.app/guest-support/linux/)
