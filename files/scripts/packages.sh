#!/usr/bin/bash

set ${SET_X:+-x} -eou pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "installing packages"

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
  	cmake glibc-devel \
   	fastfetch
       
     
dnf5 -y swap ffmpeg-free ffmpeg --allowerasing
dnf5 -y group install multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin