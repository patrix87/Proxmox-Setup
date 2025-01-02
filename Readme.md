# Here are my personnal Proxmox Setup Notes

Install Proxmox Virtual Environment : https://www.proxmox.com/en/proxmox-virtual-environment/get-started
Change the root password via the ui
Create one LVM Volume for each disks

Download the required ISO:
bash -c "$(wget -qLO - https://github.com/community-scripts/ProxmoxVE/raw/main/misc/post-pve-install.sh)"

Run : https://community-scripts.github.io/ProxmoxVE/scripts?id=post-pve-install from the built in PVE shell (Not SSH) (Yes to all)
bash -c "$(wget -qLO - https://github.com/community-scripts/ProxmoxVE/raw/main/misc/post-pve-install.sh)"

### Setup Webhook notifications

```
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

Create the linux server cloudinit template
