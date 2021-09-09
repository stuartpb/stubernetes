cat <(curl -L https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.50.0/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagerconfigs.yaml) \
<(curl -L https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.50.0/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagers.yaml) \
<(curl -L https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.50.0/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml) \
<(curl -L https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.50.0/example/prometheus-operator-crd/monitoring.coreos.com_probes.yaml) \
<(curl -L https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.50.0/example/prometheus-operator-crd/monitoring.coreos.com_prometheuses.yaml) \
<(curl -L https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.50.0/example/prometheus-operator-crd/monitoring.coreos.com_prometheusrules.yaml) \
<(curl -L https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.50.0/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml) \
<(curl -L https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.50.0/example/prometheus-operator-crd/monitoring.coreos.com_thanosrulers.yaml) \
> prometheus.crds.yaml
