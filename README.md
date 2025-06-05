[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/my-atomic-os)](https://artifacthub.io/packages/container/my-atomic-os/my-atomic-os)
[![Build my-atomic-os](https://github.com/my-atomic-os/my-atomic-os/actions/workflows/build.yml/badge.svg)](https://github.com/my-atomic-os/my-atomic-os/actions/workflows/build.yml)
[![Shellcheck](https://github.com/my-atomic-os/my-atomic-os/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/my-atomic-os/my-atomic-os/actions/workflows/shellcheck.yml)

# this is fedora silverblue with my modifications applied
# features

### 1- python3-validity installed from [copr repo](https://copr.fedorainfracloud.org/coprs/sneexy/python-validity/) by default
### 2- codecs are installed by default
### 3- based on [fedora bootc image](https://quay.io/fedora/fedora-silverblue)
# install steps

### 1- download silverblue os first from [torrent](https://torrent.fedoraproject.org/) flash it on a usb drive or use ventoy  

### 2- install it

### 3- run the following to switch to my-atomic-os:

### 3a- install secret:
#### 3a1- clone the repo
```
git clone https://github.com/my-atomic-os/my-atomic-os
```
#### 3a2- run the script
```
sudo sh ./my-atomic-os/install_secret.sh
```
#### 3a3- delete the repo
```
rm -rf ./my-atomic-os
```

### 3b- switch to my image (signed)
```
sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/my-atomic-os/my-atomic-os:latest
```

### 3c- reboot to image
```
systemctl reboot
```

## after install steps (recommended)
### 1- fix systemd-remount-fs.service

### 2- add # to / entry in fstab (the first uncommented entry not starting with #)
```
sudo nano /etc/fstab
``` 

### 3- restore zstd compression
```
sudo rpm-ostree kargs --delete=rootflags=subvol=root --append=rootflags=subvol=root,compress=zstd:1
```


### 4- fix validity
```
sudo validity-sensors-firmware
```
```
sudo systemctl restart python3-validity
```

### 5- verify the service has started correctly
```
systemctl status python3-validity
```

### 6- restart open-fprintd
```
sudo systemctl restart open-fprintd
```
