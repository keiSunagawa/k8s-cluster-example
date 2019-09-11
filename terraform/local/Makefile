.PHONY: create-roleconfig
create-roleconfig:
	terraform output eks_configmap | kubectl apply -f -
