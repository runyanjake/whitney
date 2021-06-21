# Whitney Prometheus

The central Prometheus instance for whitney. Communicates with other containers via bridge networks and provides metrics to Grafana via its own bridge network.
</br>
Custom configuration held in `prometheus.yml`. Adding a new metrics source should update prometheus.yml, as well as making sure docker-compose.yml is aware of the new bridge network, if any.
</br>
Since there is a circular dependency between the network usage of `../grafana` and this, you may need to manually create the networks `grafana_grafana_whitney` or `prometheus_prometheus_whitney`. 

### Start with Docker-Compose

`docker-compose up -d`

