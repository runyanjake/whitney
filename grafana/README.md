# Whitney Grafana

Base grafana instance. I am configuring it to read Node Exporter metrics from Prometheus.
Custom configuration held in grafana.ini.

### Start with Docker-Compose

`docker-compose up -d`

### Start with Plain Docker

`docker run -d --name="grafana_whitney" --restart=always -p 3000:3000 --mount type=bind,source=/home/grafana/whitney.ini,target=/etc/grafana/grafana.ini grafana/grafana`
