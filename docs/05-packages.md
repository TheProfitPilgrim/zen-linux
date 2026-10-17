# Zen Linux — Software Installation Guide

This document records the software used in Zen Linux, why we need it, and how to install it on Debian 13 ARM64.

## 1. Update Debian

```bash
sudo apt update
```

## 2. Desktop Environment

```bash
sudo apt install xorg i3-wm i3status lightdm alacritty
```

| Package | Purpose |
|---|---|
| `xorg` | X11 graphical display system |
| `i3-wm` | Tiling window manager |
| `i3status` | Status information for i3bar |
| `lightdm` | Graphical login manager |
| `alacritty` | Terminal emulator |

## 3. UTM Integration

```bash
sudo apt install spice-vdagent xinput
```

| Package | Purpose |
|---|---|
| `spice-vdagent` | Clipboard integration and display-related features |
| `xinput` | Inspect and manage input devices |

Display configuration:

- Virtual graphics card: `virtio-gpu-pci`
- Auto Resolution: Disabled
- Retina Mode: Disabled
- Scaling: Linear
- Fixed guest resolution: 1920 × 1080 at 60 Hz

The guest resolution is configured in `config/i3/config`.

### Natural scrolling

Our X11 input configuration is stored at:

`config/x11/40-zen-mouse.conf`

Install it using:

```bash
sudo cp config/x11/40-zen-mouse.conf /etc/X11/xorg.conf.d/
```

A new graphical session is required for the setting to take effect.

## 4. Development Tools

```bash
sudo apt install git neovim
```

| Package | Purpose |
|---|---|
| `git` | Version control and GitHub workflows |
| `neovim` | Terminal-based text editor |

Neovim is installed, but our complete personalized Neovim configuration has not yet been transferred from macOS.

GitHub repository:

https://github.com/TheProfitPilgrim/zen-linux

SSH keys and private credentials must never be committed.

## 5. Browsers

```bash
sudo apt install firefox-esr chromium
```

| Package | Purpose |
|---|---|
| `firefox-esr` | Primary web browser |
| `chromium` | Alternative Chromium-based browser |

### Performance notes

Our current VM reports:

- OpenGL renderer: `llvmpipe`
- Hardware-accelerated OpenGL: No

Chromium performed poorly in this environment. Firefox ESR was more usable.

Testing suggested that a fixed 1920 × 1080 display is more responsive than our original higher-resolution configuration.

An experiment with `virtio-gpu-gl-pci` caused serious text-rendering problems, so we restored `virtio-gpu-pci`.

## 6. Sakura Dusk Wallpaper System

```bash
sudo apt install rofi feh
```

| Package | Purpose |
|---|---|
| `rofi` | Application launcher and visual wallpaper selector |
| `feh` | Image viewer and wallpaper setter |

Wallpaper directory:

`profiles/sakura-dusk/wallpapers/`

Wallpaper picker:

`profiles/sakura-dusk/rofi/wallpaper-picker.sh`

The picker automatically discovers JPG, PNG, and WebP images in the wallpaper directory.

### Wallpaper picker usage

Launch using:

**Option / Start + Shift + W**

Controls:

- Arrow keys: Navigate
- Enter: Apply wallpaper
- Esc: Cancel
- Type: Filter wallpapers
- Mouse: Select wallpaper

The picker uses Rofi's image-icon support and a custom Sakura Dusk theme.

### Wallpaper sources

See:

`profiles/sakura-dusk/wallpapers/SOURCES.md`

Third-party wallpapers should only be redistributed when their licensing permits it.

## 7. Graphics Diagnostics

```bash
sudo apt install mesa-utils
```

Useful commands:

```bash
glxinfo -B
xrandr
free -h
top
```

These help diagnose graphics acceleration, display modes, memory usage, and CPU activity.

## 8. Installing Everything

For an already-installed Debian 13 system, the packages documented above can be installed using:

```bash
sudo apt update
sudo apt install \
  xorg i3-wm i3status lightdm alacritty \
  spice-vdagent xinput \
  git neovim \
  firefox-esr chromium \
  rofi feh mesa-utils
```

This installs the software but does not automatically deploy our configuration files or reproduce the UTM hardware settings.

We will document configuration deployment separately as the setup develops.

## 9. Maintenance

Whenever we install another package:

1. Record its name and purpose here.
2. Add it to the appropriate installation commands.
3. Update `packages/debian.txt` if needed.
4. Commit the documentation together with the configuration that uses it.

