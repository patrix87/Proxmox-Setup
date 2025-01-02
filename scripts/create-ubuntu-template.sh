#!/bin/bash
vm_id=9000
vm_pool=sata-870-qvo-1tb-01
vm_disk=/var/lib/vz/template/iso/ubuntu-24.04-server-cloudimg-amd64.img
vm_name=ubuntu-24
# Modify the image
apt update -y
apt upgrade -y
apt install libguestfs-tools -y
virt-customize -a ${vm_disk} --install qemu-guest-agent
# Create a new VM with the ID ${vm_id} and the name ${vm_name}
qm create ${vm_id} --memory 4096 --core 4 --name ${vm_name} --net0 virtio,bridge=vmbr0
# Import the ${vm_name} cloud image to the ${vm_pool} storage
qm disk import ${vm_id} ${vm_disk} ${vm_pool}
# Set the ${vm_id} VM to use the ${vm_pool} storage
qm set ${vm_id} --scsihw virtio-scsi-pci --scsi0 ${vm_pool}:vm-${vm_id}-disk-0
# Set the ${vm_id} VM to use the ${vm_pool} cloudinit storage
qm set ${vm_id} --ide2 ${vm_pool}:cloudinit
# Set the ${vm_id} VM to boot from the ${vm_pool} cloud image
qm set ${vm_id} --boot c --bootdisk scsi0
# Set the ${vm_id} VM to use the serial0 socket and the serial0 VGA
qm set ${vm_id} --serial0 socket --vga serial0
# Enable QEUM Guest Agent
qm set ${vm_id} --agent enabled=1
# Set the ${vm_id} VM to use the user "user"
qm set ${vm_id} --ciuser "user"
# Set the ${vm_id} VM to use DHCP
qm set ${vm_id} --ipconfig0 ip=dhcp
# Convert the VM to a Template
qm template ${vm_id}