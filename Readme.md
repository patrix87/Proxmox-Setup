# Here are my personnal Proxmox Setup Notes

- Install Proxmox Virtual Environment : <https://www.proxmox.com/en/proxmox-virtual-environment/get-started>
- Change the root password via the ui
- Create one LVM Volume for each disks

## Authentication

- Generate an ssh key pair with `ssh-keygen -t rsa`
- Upload your public key to the server using:
`type $env:USERPROFILE\.ssh\id_rsa.pub | ssh {IP-ADDRESS-OR-FQDN} "cat >> .ssh/authorized_keys"`

## Upload the required ISO to Proxmox

- `bash -c "$(wget -qLO - https://github.com/patrix87/Proxmox-Setup/raw/main/scripts/download-iso.sh)"`

## Run Post [Install Scripts](https://community-scripts.github.io/ProxmoxVE/scripts?id=post-pve-install)

- From the built in PVE shell (Yes to all)
- `bash -c "$(wget -qLO - https://github.com/community-scripts/ProxmoxVE/raw/main/misc/post-pve-install.sh)"`

## Setup Webhook notifications

```null
Endpoint Name: Discord
Enabled: true
POST: https://discord.com/api/webhooks/1234567890123456789/{{ secrets.token }}
HEADER:
Content-Type: application/json
BODY: 
{
    "content": null,
    "embeds": [
        {
            "title": "{{ escape title }}",
            "description": "{{ escape message }}",
            "color": 16711680,
            "footer": {
                "text": "Proxmox"
            }
        }
    ],
    "attachments": []
}
SECRETS: 
token: *****************
```

## Create the linux server cloudinit template

- `bash -c "$(wget -qLO - https://github.com/patrix87/Proxmox-Setup/raw/main/scripts/create-ubuntu-template.sh)"`
- Add your Public SSH Key or Password to the Template Cloud-Init
- Resize the Disk after cloning

## Upload the Windows Server ISO to Promox

- Download ISO from : <https://www.microsoft.com/en-us/evalcenter/download-windows-server-2025>
- Create the template using the script:
- `bash -c "$(wget -qLO - https://github.com/patrix87/Proxmox-Setup/raw/main/scripts/create-windows-template.sh)"`
- Boot the VM and install the [VirtIO Driver](https://pve.proxmox.com/wiki/Windows_VirtIO_Drivers#Using_the_ISO)
- Install the [QEMU Guest Agent](https://pve.proxmox.com/wiki/Qemu-guest-agent)
- Install any other base tools that you want in that Template
- Run the Updates
- Remove Azure Arc Setup with `Remove-WindowsCapability -online -Name AzureArcSetup~~~~`
- Remove Windows Admin Centre Setup `Remove-WindowsFeature -Name WindowsAdminCenterSetup`
- Uninstall Paint and Feedback Hub
- Enable RDP
- Disable Firewall
- Disable Microsoft Defender
- Disable IE Enhanced Security Configuration
- Set the TimeZone
- Change the Hostname
- Set the Administrator Password
- Disable "Show more options" context menu with `reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve`
- Install Powershell 7
- Install Git
- Convert to Template
