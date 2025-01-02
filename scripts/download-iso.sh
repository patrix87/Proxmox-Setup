#!/bin/bash
ubuntu_version="24.04"
iso_path="/var/lib/vz/template/iso/"
# Download the latest version of the Ubuntu ${ubuntu_version} cloud image to ${iso_path}
wget -P ${iso_path} https://cloud-images.ubuntu.com/releases/${ubuntu_version}/release/ubuntu-${ubuntu_version}-server-cloudimg-amd64.img
# Download the SHA256SUMS and SHA256SUMS.gpg files to ${iso_path}
wget -P ${iso_path} https://cloud-images.ubuntu.com/releases/${ubuntu_version}/release/SHA256SUMS
wget -P ${iso_path} https://cloud-images.ubuntu.com/releases/${ubuntu_version}/release/SHA256SUMS.gpg
# Verify the SHA256SUMS file
if (gpg --verify ${iso_path}SHA256SUMS.gpg ${iso_path}SHA256SUMS 2>&1 | grep "Good signature") ; then
    echo "SHA256SUMS file is verified"
else
    echo "SHA256SUMS file is not verified"
    exit 1
fi
rm SHA256SUMS SHA256SUMS.gpg

# Download the latest version of the VirtIO drivers ISO
wget -P ${iso_path} --content-disposition https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/virtio-win.iso

# Download Promox Backup Server
wget -P ${iso_path} --content-disposition https://enterprise.proxmox.com/iso/proxmox-ve_8.3-1.iso
