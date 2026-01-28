.PHONY: preInstall installMonitor uninstallMonitor portForward portForwardStop portForwardStart


MONITOR_RELEASE				= sl-monitor
MONITOR_NAMESPACE 			= sl-monitor
GRAFANA_SERVICE_NAME		= service/grafana
GRAFANA_PRIVATE_PORT		= 80
GRAFANA_PUBLIC_PORT			= 3000
GRAFANA_USERNAME			= admin
GRAFANA_PASSWORD			= admin

preInstall:
	cd ./deploy && helm dependency update

installMonitor: preInstall
	helm install -n $(MONITOR_NAMESPACE) $(MONITOR_RELEASE) ./deploy  \
		--wait --create-namespace \
		--values ./deploy/values-monitor.yaml \
		--set grafana.adminUser=$(GRAFANA_USERNAME) \
		--set grafana.adminPassword=$(GRAFANA_PASSWORD)

uninstallMonitor:
	helm uninstall $(MONITOR_RELEASE) -n $(MONITOR_NAMESPACE)

portForward: portForwardStop portForwardStart

portForwardStart:
	@kubectl -n $(MONITOR_NAMESPACE) port-forward $(GRAFANA_SERVICE_NAME) \
		$(GRAFANA_PUBLIC_PORT):$(GRAFANA_PRIVATE_PORT) &> /dev/null  &
	@sleep 2
	@echo "------------------------------------------"
	@echo ""
	@echo "Grafana is Ready!"
	@echo ""
	@echo "http://localhost:$(GRAFANA_PUBLIC_PORT)"
	@echo ""
	@echo "username: $(GRAFANA_USERNAME)"
	@echo "password: $(GRAFANA_PASSWORD)"
	@echo ""
	@echo "------------------------------------------"

portForwardStop:
	@pkill -f "port-forward $(GRAFANA_SERVICE_NAME)" || true
	@echo "Port forward stopped"
