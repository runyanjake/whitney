# Whitney Configuration

Configuration info for running and maintaining Whitney.

### Links

www.whitney.rip

### Services

##### Covid 19 App

Covid 19 app from `https://github.com/KevRunAmok/Covid19app` & dockerized by me to build both the app and the dependancy mysql container.

##### Grafana

Grafana instance for Whitney. Serves Node-Exporter system metrics held in Prometheus.
Served at `www.grafana.whitney.rip`.

##### Minecraft

Spigot Minecraft server. Served on `www.whitney.rip:25565`.

##### Node

A simple node server from https://github.com/runyanjake/node_whitney, dockerized for ease of use.

##### Node-Exporter

System metrics exporter that exports system metrics to Prometheus, where they are exposed to Grafana.

##### Plex

Self-hosted plex instance.

##### Prometheus

Prometheus vanilla instance that reads from Node-Exporter and exports metrics for Grafana to read.

