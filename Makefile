.PHONY: preInstall installMonitor uninstallMonitor


MONITOR_RELEASE				= sl-monitor
MONITOR_NAMESPACE 			= sl-monitor

preInstall:
	cd ./deploy && helm dependency update

installMonitor: preInstall
	helm install -n $(MONITOR_NAMESPACE) $(MONITOR_RELEASE) ./deploy  \
		--wait --create-namespace \
		--values ./deploy/values-monitor.yaml

uninstallMonitor:
	helm uninstall $(MONITOR_RELEASE) -n $(MONITOR_NAMESPACE)
