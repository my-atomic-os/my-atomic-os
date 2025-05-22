#!/usr/bin/bash

set ${SET_X:+-x} -eou pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "installing packages"


dnf5 -y group install development-tools
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
 			chezmoi \
  			cmake glibc-devel \
   			fastfetch \
			gnome-backgrounds-extras \
 			gnome-themes-extra \
  			gnome-tweaks \
      			automake autoconf \
	 		cups-devel

dnf5 remove -y  fedora-workstation-backgrounds \
	       	desktop-backgrounds-gnome \
                f42-backgrounds-gnome \
                gnome-classic-session \
                gnome-shell-extension-apps-menu \
                gnome-shell-extension-launch-new-instance \
                gnome-shell-extension-places-menu \
                gnome-shell-extension-window-list \
	       	gnome-shell-extension-background-logo \
	     	fedora-bookmarks \
       		fedora-chromium-config \
	 	fedora-chromium-config-gnome \
   		gnome-software-rpm-ostree
       
dnf5 -y swap ffmpeg-free ffmpeg --allowerasing
dnf5 -y group install multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
