#!/bin/bash

set -ouex pipefail

log "enable services"
systemctl enable podman.socket \
	open-fprintd.service \
	python3-validity.service \
	open-fprintd-restart-after-resume.service \
	python3-validity-restart-after-resume.service \
	libvirtd.service \
  	chronyd.service

log  "disable services"
systemctl disable open-fprintd-resume.service \
	open-fprintd-suspend.service
