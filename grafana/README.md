# Whitney Grafana

Base grafana instance. I am configuring it to read Node Exporter metrics from Prometheus.
Custom configuration held in grafana.ini.
</br>
After starting this image, we still need to create a datasource. Select Prometheus as the type, and `www.whitney.rip:9090` is the address. Everything else can be default.
</br>
We also need to create a dashboard if starting from scratch. A good default one for node-exporter is `1860`.

### Start with Docker-Compose

`docker-compose up -d`

### Start with Plain Docker

`docker run -d --name="grafana_whitney" --restart=always -p 3000:3000 --mount type=bind,source=/home/grafana/whitney.ini,target=/etc/grafana/grafana.ini grafana/grafana`
