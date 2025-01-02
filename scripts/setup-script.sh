#!/bin/bash
# Disable root password authentication
sed -i 's/PermitRootLogin yes/PermitRootLogin prohibit-password/g' /etc/ssh/sshd_config
systemctl restart sshd