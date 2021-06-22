# Whitney Configuration

Configuration info for running and maintaining Whitney.

### Links

www.whitney.rip

### Services

##### Certbot

Certbot helps me keep my letsencrypt certificates up to date for whitney.rip.

##### Covid 19 App

Covid 19 app from `https://github.com/KevRunAmok/Covid19app` & dockerized by me to build both the app and the dependancy mysql container.

##### Grafana

Grafana instance for Whitney. Creates a Grafana and Node-Exporter instance that interface with the Prometheus instance. 
Served at `grafana.whitney.rip`.

##### Minecraft

Minecraft servers, dockerized. Emits metrics that are read by Prometheus, and shown in grafana. Responsible for spinning up the servers that run at `mc.whitney.rip` and `minecraft.whitney.rip`. Metrics are emitted for both servers to Grafana.

##### Node

A simple node server from https://github.com/runyanjake/node_whitney, dockerized for ease of use.

##### Plex

Self-hosted plex instance.

##### Portainer

Admin console for monitoring docker containers.

##### Prometheus

Central Prometheus instance responsible for gathering metrics and exposing them to Grafana.

