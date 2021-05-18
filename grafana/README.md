# Whitney Grafana

Grafana instance for Whitney that produces system metrics. Creates a Node-Exporter container that reads system metrics and creates a Prometheus instance that it sends metrics to. Grafana can be configured to read from Prometheus once created.
</br>
Custom configuration held in grafana.ini.
</br>
After starting this image, we still need to create a datasource. Select Prometheus as the type, and `prometheus_whitney:9090` is the address. Everything else can be default.
</br>
We also need to create a dashboard if starting from scratch. A good default one for node-exporter is `1860`.

### Start with Docker-Compose

`docker-compose up -d`

