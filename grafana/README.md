# Whitney Grafana

Grafana instance for Whitney that produces system metrics. Creates a Node-Exporter container that reads system metrics. A bridge network is created to allow Prometheus to query Node Exporter for metrics. Grafana connects to Prometheus via its bridge network to gather aggregated metrics.
</br>
Custom configuration held in grafana.ini.
</br>
After starting this image, we still need to create a datasource. Select Prometheus as the type, and `prometheus_whitney:9090` is the address. Everything else can be default.
</br>
We also need to create a dashboard if starting from scratch. A good default one for node-exporter is `1860`.

### Start with Docker-Compose

`docker-compose up -d`

#### Customization Notes
Images can be hosted by imgur and added in html to a Text Panel.

