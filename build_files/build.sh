#!/bin/bash

set ${SET_X:+-x} -eou pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "setting up my-atomic-os build proccess"

log "setting up repos"
sh /ctx/repo.sh

log "installig packages"
sh /ctx/packages.sh

log "setting up services"
sh /ctx/services.sh

log "fixing signing"
sh /ctx/signing.sh

log "clean build env"
sh /ctx/cleanup.sh

log "build is successful"
