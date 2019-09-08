.PHONY: init
init:
	kube apply -f helm-auth.yml
	helm init --service-account=tiller --history-max 200

.PHONY: install-dashboard
install-dashboard:
	helm install stable/kubernetes-dashboard --name dsbd --set=rbac.clusterAdminRole=true
