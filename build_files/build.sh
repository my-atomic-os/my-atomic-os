#!/bin/bash

set ${SET_X:+-x} -eou pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "setting up my-atomic-os build proccess"

log "setting up repos"
/ctx/repo.sh

log "installig packages"
/ctx/packages.sh

log "setting up services"
/ctx/services.sh

log "fixing signing"
/ctx/signing.sh

log "clean build env"
/ctx/cleanup.sh
