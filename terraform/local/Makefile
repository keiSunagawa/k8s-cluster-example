.PHONY: create-roleconfig
create-roleconfig:
	terraform output eks_configmap | kube apply -f -
