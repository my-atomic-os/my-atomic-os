[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/my-atomic-os)](https://artifacthub.io/packages/search?repo=my-atomic-os)
### my thinkpad-t480 os config

### download silverblue os first from torrent flash it on a usb drive or use ventoy and install it
https://torrent.fedoraproject.org/

### fix systemd-remount-fs.service
## add # to / entry in fstab
`sudo nano /etc/fstab` 

## restore zstd compression
`sudo rpm-ostree kargs --delete=rootflags=subvol=root --append=rootflags=subvol=root,compress=zstd:1`

### install my image

### install secret
`git clone https://github.com/Tammam20/my-atomic-os && sudo sh ./my-atomic-os/install_secret.sh && rm -rf ./my-atomic-os`

### switch to my image (signed)
`sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/tammam20/my-atomic-os:latest`

### reboot to image

`systemctl reboot`

### fix validity
`sudo validity-sensors-firmware`

`sudo systemctl restart python3-validity`

## verify the service has started correctly
`systemctl status python3-validity`

## restart open-fprintd
`sudo systemctl restart open-fprintd`

