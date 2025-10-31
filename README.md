# Headless NixOS

A minimal NixOS configuration ready for bare-metal deployment with SSH access.

## Features

- **Minimal Configuration**: Lightweight setup for headless servers
- **SSH Access**: OpenSSH server enabled and configured
- **Default User**: Username `nixos` with password `changeit`
- **NixOS 25.05**: Stable release
- **Multi-Architecture**: Supports x86_64 (ISO) and ARM64/aarch64 (Raspberry Pi 4 and Compute Module 4)
- **Automated Builds**: GitHub Actions workflow to build and release images

## Quick Start

### Download Pre-built Images

Download the latest images from the [Releases](https://github.com/ismymiddlename/headless-nixos/releases) page:
- **x86_64 ISO**: For regular PCs and servers
- **Raspberry Pi 4/CM4 SD Image**: For Raspberry Pi 4 and Compute Module 4 (ARM64/aarch64)

### Build Locally

Requirements:
- Nix with flakes enabled
- For Raspberry Pi 4: QEMU with aarch64 support (for cross-compilation on x86_64)

#### x86_64 ISO

```bash
# Clone the repository
git clone https://github.com/ismymiddlename/headless-nixos.git
cd headless-nixos

# Build the ISO
nix build .#iso

# The ISO will be available in result/iso/
ls -lh result/iso/
```

#### Raspberry Pi 4/CM4 SD Image

```bash
# Clone the repository
git clone https://github.com/ismymiddlename/headless-nixos.git
cd headless-nixos

# Build the SD card image (requires aarch64 support)
nix build .#packages.aarch64-linux.sd-image

# The SD image will be available in result/sd-image/
ls -lh result/sd-image/
```

## Deployment

### x86_64 (ISO)

1. Write the ISO to a USB drive or burn it to a CD/DVD
2. Boot your target machine from the ISO
3. The system will boot with SSH enabled
4. Connect via SSH:
   ```bash
   ssh nixos@<target-ip>
   # Password: changeit
   ```

### Raspberry Pi 4 / Compute Module 4

1. Write the SD card image to an SD card (minimum 8GB recommended):
   ```bash
   # Decompress if needed (for .zst files)
   zstd -d nixos-sd-image-*.img.zst
   
   # Write to SD card (replace /dev/sdX with your SD card device)
   sudo dd if=nixos-sd-image-*.img of=/dev/sdX bs=4M status=progress conv=fsync
   ```
   Or use a GUI tool like [balenaEtcher](https://www.balena.io/etcher/) or [Raspberry Pi Imager](https://www.raspberrypi.com/software/)

2. Insert the SD card into your Raspberry Pi 4 or CM4 carrier board
3. Connect Ethernet cable (recommended for first boot)
4. Power on the Raspberry Pi 4 or CM4
5. Wait for the system to boot (first boot may take longer)
6. Find the IP address (check your router or use `nmap`)
7. Connect via SSH:
   ```bash
   ssh nixos@<target-ip>
   # Password: changeit
   ```

## Default Credentials

- **Username**: `nixos`
- **Password**: `changeit`
- **SSH**: Enabled on port 22
- **Sudo**: Passwordless for wheel group

⚠️ **Security Warning**: Change the default password immediately after first login!

## Configuration

The main configuration is in `configuration.nix`. Key settings:

- SSH server with password authentication enabled and firewall port 22 automatically opened
- DHCP networking enabled
- Basic tools included: vim, wget, curl, git

## Customization

To customize the configuration:

1. Edit `configuration.nix` with your desired settings
2. Rebuild the ISO:
   ```bash
   nix build .#iso
   ```

## Raspberry Pi Compute Module 4 Notes

The SD image is compatible with both Raspberry Pi 4 and Compute Module 4, as they use the same BCM2711 SoC. Key considerations for CM4:

- **CM4 with eMMC**: Use `rpiboot` tool to expose eMMC as a USB mass storage device, then write the image using the same method as SD cards
- **CM4 Lite** (no eMMC): Use SD card exactly like Raspberry Pi 4
- **Carrier Board Dependencies**: Ensure your CM4 carrier board exposes necessary interfaces (Ethernet, USB, etc.)
- **WiFi/Bluetooth**: Only available on CM4 variants with wireless capability

## GitHub Actions

The repository includes a GitHub Actions workflow that:
- Builds both x86_64 ISO and Raspberry Pi 4/CM4 SD images automatically on tag pushes
- Creates releases with both images as artifacts
- Can be triggered manually via workflow_dispatch

To create a release:
```bash
git tag v1.0.0
git push origin v1.0.0
```

Both architectures are built in parallel to optimize build time.

## License

This configuration is provided as-is for deployment purposes.