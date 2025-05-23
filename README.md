[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/my-atomic-os)](https://artifacthub.io/packages/container/my-atomic-os/my-atomic-os)
[![Build my-atomic-os](https://github.com/Tammam20/my-atomic-os/actions/workflows/build.yml/badge.svg)](https://github.com/Tammam20/my-atomic-os/actions/workflows/build.yml)
[![Shellcheck](https://github.com/Tammam20/my-atomic-os/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/Tammam20/my-atomic-os/actions/workflows/shellcheck.yml)

# my thinkpad-t480 os config
# features
### 1- python3-validity installed from [copr repo](https://copr.fedorainfracloud.org/coprs/sneexy/python-validity/) by default
### 2- udev rules for switching from powersave to balanced based on power source

# install steps
### 1- download silverblue os first from [torrent](https://torrent.fedoraproject.org/) flash it on a usb drive or use ventoy  
### 2- install it
## after install steps (recommended)

### fix systemd-remount-fs.service
### add # to / entry in fstab
`sudo nano /etc/fstab` 

### restore zstd compression
`sudo rpm-ostree kargs --delete=rootflags=subvol=root --append=rootflags=subvol=root,compress=zstd:1`

### install secret
`git clone https://github.com/Tammam20/my-atomic-os && sudo sh ./my-atomic-os/install_secret.sh && rm -rf ./my-atomic-os`

### switch to my image (signed)
`sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/tammam20/my-atomic-os:latest`

### reboot to image

`systemctl reboot`

### fix validity
`sudo validity-sensors-firmware`

`sudo systemctl restart python3-validity`

### verify the service has started correctly
`systemctl status python3-validity`

## restart open-fprintd
`sudo systemctl restart open-fprintd`

