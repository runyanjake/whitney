# Whitney Node Exporter

Node Exporter for Whitney that emits metrics for system usage. Read by Prometheus and fed into Grafana for a nice looking visualization of the system.

### Start with Docker-Compose

docker-compose up -d

### Start with plain Docker

docker run -d --net="host" --pid="host" --restart=always --name="node_exporter_whitney" -v "/:/host:ro,rslave" quay.io/prometheus/node-exporter:latest --path.rootfs=/host

