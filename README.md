# Headless NixOS

A minimal NixOS configuration ready for bare-metal deployment with SSH access.

## Features

- **Minimal Configuration**: Lightweight setup for headless servers
- **SSH Access**: OpenSSH server enabled and configured
- **Default User**: Username `nixos` with password `changeit`
- **NixOS 25.05**: Stable release
- **Automated Builds**: GitHub Actions workflow to build and release ISO images

## Quick Start

### Download Pre-built ISO

Download the latest ISO from the [Releases](https://github.com/ismymiddlename/headless-nixos/releases) page.

### Build Locally

Requirements:
- Nix with flakes enabled

```bash
# Clone the repository
git clone https://github.com/ismymiddlename/headless-nixos.git
cd headless-nixos

# Build the ISO
nix build .#iso

# The ISO will be available in result/iso/
ls -lh result/iso/
```

## Deployment

1. Write the ISO to a USB drive or burn it to a CD/DVD
2. Boot your target machine from the ISO
3. The system will boot with SSH enabled
4. Connect via SSH:
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

- SSH server with password authentication enabled
- DHCP networking enabled
- Firewall configured to allow SSH (port 22)
- Basic tools included: vim, wget, curl, git

## Customization

To customize the configuration:

1. Edit `configuration.nix` with your desired settings
2. Rebuild the ISO:
   ```bash
   nix build .#iso
   ```

## GitHub Actions

The repository includes a GitHub Actions workflow that:
- Builds the ISO automatically on tag pushes
- Creates releases with the ISO as an artifact
- Can be triggered manually via workflow_dispatch

To create a release:
```bash
git tag v1.0.0
git push origin v1.0.0
```

## License

This configuration is provided as-is for deployment purposes.