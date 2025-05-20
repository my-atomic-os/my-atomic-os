#!/bin/bash
### fix signing

set ${SET_X:+-x} -eou pipefail

### Signing
mkdir -p /etc/containers
mkdir -p /etc/pki/containers
mkdir -p /etc/containers/registries.d/

cp ./my-atomic-os/cosign.pub /etc/pki/containers/cosign.pub

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
