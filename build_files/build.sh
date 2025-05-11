#!/bin/bash

set ${SET_X:+-x} -eou pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "setting up my-atomic-os build proccess"

log "setting up repos"
chmod +x /ctx/repo.sh
/ctx/repo.sh

log "installig packages"
chmod +x /ctx/packages.sh
/ctx/packages.sh

log "setting up services"
chmod +x /ctx/services.sh
/ctx/services.sh

log "fixing signing"
chmod +x /ctx/signing.sh
/ctx/signing.sh

log "clean build env"
chmod +x /ctx/cleanup.sh
/ctx/cleanup.sh

log "build is successful"
