#!/bin/bash

set -ouex pipefail

dnf5 -y group install --with-optional virtualization
dnf5 install -y mozilla-openh264 \
	open-fprintd \
	fprintd-clients \
	fprintd-clients-pam \
	python3-validity \
 	code \
   	rust cargo clippy rustfmt \
    	rust-src \
    	lm_sensors stress-ng \
    	rpmfusion-\*-appstream-data \
     	intel-media-driver \
      	python3-pip rclone \
       	chromium \
	distrobox gh \
 	"https://github.com/twpayne/chezmoi/releases/download/v2.62.2/chezmoi-2.62.2-x86_64.rpm" \
  	cmake glibc-devel \
   	fastfetch mdevctl
       
     
dnf5 -y swap ffmpeg-free ffmpeg --allowerasing
dnf5 -y group install multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

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
