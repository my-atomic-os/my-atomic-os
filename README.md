### my thinkpad-t480 os config

### download silverblue os first from torrent flash it or use ventoy and install it
https://torrent.fedoraproject.org/

### install my image

### install secret
`git clone https://github.com/Tammam20/my-atomic-os && sudo sh ./my-atomic-os/install_secret.sh` && rm -rf ./my-atomic-os

### switch to my image (signed)
`sudo bootc switch --enforce-container-sigpolicy ghcr.io/tammam20/my-atomic-os:latest`

### reboot to image

`systemctl reboot`
