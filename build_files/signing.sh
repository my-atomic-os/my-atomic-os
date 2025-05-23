#!/usr/bin/bash

set ${SET_X:+-x} -eou pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}


log  "fixing signing"
mkdir -p /etc/containers
mkdir -p /etc/pki/containers
mkdir -p /etc/containers/registries.d/

cp /ctx/cosign.pub /etc/pki/containers/cosign.pub

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


