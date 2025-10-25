# Testing Guide

## Automated Testing (GitHub Actions)

The GitHub Actions workflow will automatically validate the configuration when triggered:

1. **Trigger via Tag**: Create and push a tag starting with 'v'
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```

2. **Manual Trigger**: Go to the Actions tab in GitHub and manually trigger the "Build and Release NixOS ISO" workflow

The workflow will:
- Check out the repository
- Install Nix with flakes support
- Build the ISO using `nix build .#iso`
- Create a release (if triggered by tag)
- Upload the ISO as an artifact

## Local Testing

If you have Nix installed locally with flakes enabled:

```bash
# Validate the flake
nix flake check

# Check the flake structure
nix flake show

# Build the ISO (this will take some time)
nix build .#iso --print-build-logs

# Check the result
ls -lh result/iso/
```

## Deployment Testing

To test the ISO on actual hardware or VM:

1. Build or download the ISO
2. Create a bootable USB or VM:
   ```bash
   # For USB (replace /dev/sdX with your USB device)
   sudo dd if=result/iso/*.iso of=/dev/sdX bs=4M status=progress && sync
   
   # For VM (using QEMU)
   qemu-system-x86_64 -cdrom result/iso/*.iso -m 2048 -enable-kvm
   ```

3. Boot from the ISO
4. Once booted, test SSH access:
   ```bash
   # From another machine
   ssh nixos@<target-ip>
   # Password: changeit
   ```

5. Verify the system:
   ```bash
   # Check NixOS version
   nixos-version
   
   # Check SSH is running
   systemctl status sshd
   
   # Check user
   whoami
   id nixos
   
   # Test sudo access
   sudo echo "Sudo works!"
   ```

## Configuration Validation

The Nix build process itself validates:
- Syntax correctness of .nix files
- Module compatibility
- Package availability
- System configuration coherence

If the build succeeds, the configuration is valid.

## Expected Results

- ISO size: ~800MB - 1GB (minimal NixOS live system with vim, wget, curl, git)
- Boot time: Fast (minimal configuration)
- SSH available immediately after boot
- User `nixos` with password `changeit` working
- Sudo access without password for wheel group
- Network configured via DHCP
