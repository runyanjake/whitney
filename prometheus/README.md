# Prometheus Whitney

A Prometheus instance that gathers metrics from node-exporter so that they may be used in Grafana.

### Build Image With Docker

`docker build -t prometheus_whitney .`

### Start With Docker-Compose

`docker-compose up -d`

### Start With Plain Docker (Does not include scraping instructions)

`docker run -d --restart=always --network=host --name="prometheus_whitney" -p 9090:9090 prometheus_whitney`

