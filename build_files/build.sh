#!/bin/bash

set -ouex pipefail

### Install packages
rpm  --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
autorefresh=1
type=rpm-md
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | \
sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf5 -y copr enable sneexy/python-validity
dnf5 -y install "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
	"https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
dnf5 -y config-manager setopt fedora-cisco-openh264.enabled=1
dnf5 -y group install virtualization
dnf5 install -y mozilla-openh264 \
	open-fprintd \
	fprintd-clients \
	fprintd-clients-pam \
	python3-validity \
 	code \
   	rustup lm_sensors stress-ng \
    	rpmfusion-\*-appstream-data \
     	intel-media-driver \
      	python3-pip rclone \
       	chromium \
	distrobox gh \
 	"https://github.com/twpayne/chezmoi/releases/download/v2.62.2/chezmoi-2.62.2-x86_64.rpm" \
  	cmake glibc-devel 
       
     
dnf5 -y swap ffmpeg-free ffmpeg --allowerasing
dnf5 -y group install multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

### enable services
systemctl enable podman.socket open-fprintd.service \
	python3-validity.service \
	open-fprintd-restart-after-resume.service \
	python3-validity-restart-after-resume.service \
	libvirtd.service

### disable services
systemctl disable open-fprintd-resume.service \
	open-fprintd-suspend.service

### fix signing
restorecon -RFv /etc/pki/containers
bash -c 'cat <<EOF > /etc/containers/registries.d/ghcr.tammam20.my-atomic-os.yaml
docker:
  ghcr.io/tammam20/my-atomic-os:
    use-sigstore-attachments: true
EOF'

cat <<EOF > /etc/containers/policy.json
{
    "default": [
        {
            "type": "reject"
        }
    ],
    "transports": {
        "docker": {
            "ghcr.io/tammam20/my-atomic-os": [
                {
                    "type": "sigstoreSigned",
                    "keyPath": "/etc/pki/containers/cosign.pub",
                    "signedIdentity": {
                        "type": "matchRepository"
                    }
                }
            ],
            "": [{"type": "insecureAcceptAnything"}]
	},
        "docker-daemon": {
	        "": [{"type": "insecureAcceptAnything"}]
	    }
    }
}
EOF