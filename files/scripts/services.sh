#!/usr/bin/bash

set ${SET_X:+-x} -eou pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "enable services"
systemctl enable podman.socket \
	open-fprintd.service \
	python3-validity.service \
	open-fprintd-restart-after-resume.service \
	python3-validity-restart-after-resume.service \
	libvirtd.service

log "disable services"
systemctl disable open-fprintd-resume.service \
	open-fprintd-suspend.service