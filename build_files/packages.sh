#!/usr/bin/bash

set ${SET_X:+-x} -eou pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "installing packages"

dnf5 install -y mozilla-openh264 \
		open-fprintd \
		fprintd-clients \
		fprintd-clients-pam \
		python3-validity \
    	lm_sensors \
      	stress-ng \
    	intel-media-driver \
    	python3-pip \
  		gh \
		chezmoi \
   		fastfetch \
 		gnome-themes-extra \
  		gnome-tweaks

dnf5 remove -y firefox \
		firefox-langpacks
dnf5 -y swap ffmpeg-free ffmpeg --allowerasing
dnf5 -y group install multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
