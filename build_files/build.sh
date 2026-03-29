#!/bin/bash
set -ouex pipefail

# bazzctl VM image customizations
# Adds: cloud-init for first-boot SSH/env config, serial console, sshd

# Install cloud-init
dnf5 install -y cloud-init

# Enable cloud-init services (create symlinks directly since systemd
# isn't running in the build container and some units may fail to enable)
ln -sf /usr/lib/systemd/system/cloud-init-local.service /etc/systemd/system/multi-user.target.wants/ 2>/dev/null || true
ln -sf /usr/lib/systemd/system/cloud-init.service /etc/systemd/system/multi-user.target.wants/ 2>/dev/null || true
ln -sf /usr/lib/systemd/system/cloud-config.service /etc/systemd/system/multi-user.target.wants/ 2>/dev/null || true
ln -sf /usr/lib/systemd/system/cloud-final.service /etc/systemd/system/multi-user.target.wants/ 2>/dev/null || true

# Enable serial console for QEMU serial log output
systemctl enable serial-getty@ttyS0.service || true

# Enable SSH server
systemctl enable sshd.service || true
