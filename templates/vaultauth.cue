package templates

import (
	vaultauthv1beta1 "secrets.hashicorp.com/vaultauth/v1beta1"
)

#VaultAuth: vaultauthv1beta1.#VaultAuth & {
	#config:  #Config
	#vc: #VaultConnection
	#sa?: #ServiceAccount

	metadata: #config.metadata
	spec: #config.auth & {
		vaultConnectionRef: #vc.metadata.name

		if #sa != _|_ {
			if kubernetes != _|_ {
			  kubernetes.serviceAccount: #sa.metadata.name
			}
		}
	}
}
