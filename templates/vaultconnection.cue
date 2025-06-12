package templates

import (
	vaultconnectionv1beta1 "secrets.hashicorp.com/vaultconnection/v1beta1"
)

#VaultConnection: vaultconnectionv1beta1.#VaultConnection & {
	#config:  #Config
	metadata: #config.metadata
	spec: {
		address:       #config.address
		skipTLSVerify: #config.skipTLSVerify
		if #config.tlsServerName != _|_ {
			tlsServerName: #config.tlsServerName
		}
		if #config.tlsCaCertSecretRef != _|_ {
			caCertSecretRef: #config.tlsCaCertSecretRef
		}
	}
}
