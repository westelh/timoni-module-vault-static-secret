package templates

import (
	vaultstaticsecretv1beta1 "secrets.hashicorp.com/vaultstaticsecret/v1beta1"
)

#StaticSecret: vaultstaticsecretv1beta1.#VaultStaticSecret & {
	#config: #Config
	#va:     #VaultAuth

	metadata: #config.metadata
	spec: #config.secret & {
		vaultAuthRef: #va.metadata.name
	}
}
