### my thinkpad-t480 os config

### download silverblue os first from torrent flash it or use ventoy and install it
https://torrent.fedoraproject.org/

### install my image

### install secret
`wget -o - https://github.com/Tammam20/my-atomic-os/blob/main/install_secret.sh | sudo bash`

### switch to my image (signed)
`sudo bootc switch --enforce-container-sigpolicy ghcr.io/tammam20/my-atomic-os:latest`

### reboot to image

`systemctl reboot`
