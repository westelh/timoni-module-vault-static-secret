package templates

import (
	timoniv1 "timoni.sh/core/v1alpha1"
	vaultauthv1beta1 "secrets.hashicorp.com/vaultauth/v1beta1"
)

// Config defines the schema and defaults for the Instance values.
#Config: {
	// The kubeVersion is a required field, set at apply-time
	// via timoni.cue by querying the user's Kubernetes API.
	kubeVersion!: string
	// Using the kubeVersion you can enforce a minimum Kubernetes minor version.
	// By default, the minimum Kubernetes version is set to 1.20.
	clusterVersion: timoniv1.#SemVer & {#Version: kubeVersion, #Minimum: "1.20.0"}

	// The moduleVersion is set from the user-supplied module version.
	// This field is used for the `app.kubernetes.io/version` label.
	moduleVersion!: string

	// The Kubernetes metadata common to all resources.
	// The `metadata.name` and `metadata.namespace` fields are
	// set from the user-supplied instance name and namespace.
	metadata: timoniv1.#Metadata & {#Version: moduleVersion}

	// The labels allows adding `metadata.labels` to all resources.
	// The `app.kubernetes.io/name` and `app.kubernetes.io/version` labels
	// are automatically generated and can't be overwritten.
	metadata: labels: timoniv1.#Labels

	// The annotations allows adding `metadata.annotations` to all resources.
	metadata: annotations?: timoniv1.#Annotations

	createSA: *true | bool

	address: string
	mount: *"kubernetes" | string
	role: string
	headers: *{} | {[_]:string}
	skipTLSVerify:       *false | bool
	tlsServerName?:      string
	tlsCaCertSecretRef?: string

	auth: vaultauthv1beta1.#VaultAuthSpec
	auth: vaultConnectionRef: metadata.name
	if createSA {
		auth: kubernetes: serviceAccount:	metadata.name
	}
}

// Instance takes the config values and outputs the Kubernetes objects.
#Instance: {
	config: #Config

	objects: {
		vc: #VaultConnection & {#config: config}
		va: #VaultAuth & {#config: config}

		if config.createSA {
			sa: #ServiceAccount & {#config: config}
		}
	}
}
