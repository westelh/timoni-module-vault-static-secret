package templates

import (
	vaultauthv1beta1 "secrets.hashicorp.com/vaultauth/v1beta1"
)

#VaultAuth: vaultauthv1beta1.#VaultAuth & {
	#config:  #Config
	metadata: #config.metadata
	spec: #config.auth
}
