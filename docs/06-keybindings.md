# Zen Linux — Keyboard Shortcuts

Our keyboard-first workflow for Debian 13, i3, and UTM on macOS.

## Keyboard Layout

We use a Logitech keyboard with three modifier keys on the left.

| Physical key | Purpose |
|---|---|
| Ctrl | Terminal and application shortcuts |
| Option / Start (middle key) | i3 modifier — `Mod1` |
| Command / Alt (right key) | macOS shortcuts, including Command + Tab |

**Important:** All i3 shortcuts below use the physical Option / Start key.

## Applications

| Shortcut | Action |
|---|---|
| Option + Enter | Open terminal |
| Option + D | Open application launcher (dmenu) |
| Option + Shift + W | Open Sakura Dusk wallpaper picker |
| Option + Shift + Q | Close focused window |

## Window Management

| Shortcut | Action |
|---|---|
| Option + F | Toggle fullscreen |
| Option + H | Split horizontally |
| Option + V | Split vertically |
| Option + S | Stacked layout |
| Option + W | Tabbed layout |
| Option + E | Toggle split layout |
| Option + Shift + Space | Toggle floating window |
| Option + Space | Switch focus between floating and tiled windows |
| Option + A | Focus parent container |

## Navigation

The current i3 config uses the following directional mapping.

| Shortcut | Action |
|---|---|
| Option + J | Focus left |
| Option + K | Focus down |
| Option + L | Focus up |
| Option + ; | Focus right |
| Option + Arrow keys | Focus in arrow direction |
| Option + Shift + directional key | Move focused window |

## Workspaces

| Shortcut | Action |
|---|---|
| Option + 1 through 9 | Switch workspace |
| Option + 0 | Switch workspace 10 |
| Option + Shift + 1 through 9 | Move window to workspace |
| Option + Shift + 0 | Move window to workspace 10 |

## Resize Mode

| Shortcut | Action |
|---|---|
| Option + R | Enter resize mode |
| J / K / L / ; | Resize in the configured direction |
| Arrow keys | Resize in arrow direction |
| Enter or Esc | Leave resize mode |

## Scratchpad

| Shortcut | Action |
|---|---|
| Option + Shift + - | Move focused window to scratchpad |
| Option + - | Show or hide scratchpad window |

## i3 Management

| Shortcut | Action |
|---|---|
| Option + Shift + C | Reload i3 configuration |
| Option + Shift + R | Restart i3 in place |
| Option + Shift + E | Exit i3 session (confirmation required) |

## Sakura Dusk Wallpaper Picker

Open the gallery using **Option + Shift + W**.

| Key | Action |
|---|---|
| Arrow keys | Navigate wallpapers |
| Enter | Apply selected wallpaper |
| Esc | Close without changing wallpaper |
| Type text | Search by filename |
| Mouse click | Select a wallpaper |

Wallpaper files are stored in:

`profiles/sakura-dusk/wallpapers/`

Picker script:

`profiles/sakura-dusk/rofi/wallpaper-picker.sh`

## UTM and macOS

| Shortcut | Action |
|---|---|
| Command + Tab | Switch between macOS applications, including UTM |

We deliberately use Option / Start for i3 so Command + Tab remains convenient.

## Display Configuration

The current UTM setup uses:

- Display device: `virtio-gpu-pci`
- Automatic resolution adjustment: Disabled
- Retina Mode: Disabled
- Resolution: 1920 × 1080
- Refresh rate: 60 Hz

The display resolution is set when i3 starts.

## Notes

These shortcuts reflect the current working configuration.
Update this document whenever keybindings change.

The authoritative i3 configuration is:

`config/i3/config`

