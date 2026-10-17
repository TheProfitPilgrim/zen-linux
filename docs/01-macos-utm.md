# 01 — Install Debian ARM64 in UTM (macOS)

**For:** Apple Silicon Macs. **Skip this guide if Debian is already installed** and go to [02 — Debian foundation](02-debian-foundation.md).

This describes the configuration used for the first Zen Linux VM (M3 MacBook Air, 16 GB host RAM), not a universal requirement. UTM interface labels may change between versions.

## A. Install UTM and obtain Debian

1. Install UTM from the [official site](https://mac.getutm.app/). The downloaded DMG can be ejected and discarded after copying the app to Applications.
2. Download the current **Debian stable `arm64` netinst ISO** from [Debian's installer page](https://www.debian.org/releases/stable/debian-installer/). **Do not select `amd64`** for a native Apple Silicon ARM64 VM.
3. Keep the ISO available until the installation finishes.

## B. Create the VM

In UTM, choose **Create → Virtualize → Linux** (not Emulate), then use these initial settings:

| Setting | Value used |
| --- | --- |
| Backend | QEMU virtualization; **Use Apple Virtualization** unchecked |
| Boot | Boot from Debian ARM64 netinst ISO |
| RAM | 6144 MiB (6 GiB) |
| CPU cores | 4 |
| Display output | Enabled |
| Experimental hardware OpenGL | Off |
| Virtual disk | 35 GiB, dynamically allocated if supported |
| Shared directory | None initially |
| Name | `Zen Linux` |

The Debian installer might display the 35 GiB disk as **37.6 GB**: these are different unit conventions, not different drives. This is a virtual disk, not a macOS partition.

## C. Debian installation choices

1. Boot the new VM and select **Graphical install**.
2. Choose language **English**, region **India** (or your actual location), and keyboard layout **American English** (if that matches your keyboard).
3. Hostname: `zen`; domain: blank.
4. Leave the **root password fields blank** so Debian configures the first user for `sudo`; create your ordinary user and password.
5. **Guided — use entire disk**, selecting only the **UTM virtual disk**. Choose **All files in one partition**. Verify the target device and partition summary before confirming disk writes.
6. Decline additional installation media. Select an appropriate archive mirror (`deb.debian.org` works) and leave the HTTP proxy empty unless your network requires one.
7. At **Software selection**, deselect desktop environments and SSH server; keep **standard system utilities** selected. We'll install the minimalist desktop explicitly.
8. When installation completes, **eject the ISO** using the UTM virtual CD/DVD control. Then continue/reboot.
9. A text login (`zen login:`) is expected. Sign in with the username and password you created.

## D. After installation

Follow [02 — Debian foundation](02-debian-foundation.md) for the desktop and tools.

### Host/guest integration settings

With the VM off, confirm UTM **Display → Auto Resolution** is on and clipboard sharing is enabled (its location may vary by UTM version). We used a `virtio-gpu-pci` display with hardware OpenGL acceleration off, Retina mode off, and linear scaling. In Debian install `spice-vdagent` and reboot the guest. The correct Linux resolution should follow the VM's window/fullscreen size without a hardcoded `xrandr` line.

See [UTM guest support](https://docs.getutm.app/guest-support/linux/), [dynamic resolution](https://docs.getutm.app/guest-support/dynamic-resolution/), and [clipboard](https://docs.getutm.app/guest-support/sharing/clipboard/).

## E. Shutdown and restart

```bash
sudo poweroff    # clean shutdown; then UTM Play to start later
sudo reboot      # restart Linux while the VM remains running
```

Our initial VM sometimes showed **“Display output is not active”** after a warm reboot, even though a cold start worked. This has *not* been conclusively diagnosed; see [troubleshooting](04-troubleshooting.md). Do not claim it is fixed merely because a subsequent reboot succeeded.
