#!/bin/bash
set -ouex pipefail

# bazzctl VM image customizations
# Base: Bazzite GNOME (ghcr.io/ublue-os/bazzite-gnome:stable)
# Adds: cloud-init for first-boot SSH/env configuration, serial console for logging

# Install cloud-init (used by bazzctl for first-boot VM configuration)
dnf5 install -y cloud-init

# Enable cloud-init services so they run on first boot
systemctl enable cloud-init-local.service
systemctl enable cloud-init.service
systemctl enable cloud-config.service
systemctl enable cloud-final.service

# Enable serial console for QEMU serial log output
systemctl enable serial-getty@ttyS0.service

# Enable SSH server
systemctl enable sshd.service
