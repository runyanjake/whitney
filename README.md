# Whitney Configuration

Configuration info for running and maintaining Whitney.

### Links

www.whitney.rip

### Services

##### Certbot

Certbot helps me keep my letsencrypt certificates up to date for whitney.rip.

##### Covid 19 App

Covid 19 app from `https://github.com/KevRunAmok/Covid19app` & dockerized by me to build both the app and the dependancy mysql container.

##### Jenkins

Jenkins instance for automating things on Whitney.

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


### Issues

- Sometimes on startup mysql/minecraft containers may fail due to lock files persisting after shutoff. Happens mainly when server is hard powered off but can still happen if soft poweroff. Fix by removing (/data/covid/mysql/mysql.sock.lock for mysql, /data/minecraft_xxxx folders for minecraft servers.


# Installation (Ubuntu Server)

1. These steps assume a fresh install of Ubuntu Server. Complete this with default selections.
2. Install Docker. Do NOT install it from the installer (snap), instead follow https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04. 
3. We also are gonna need Docker Compose: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04
4. Install OpenSSH (`apt-get install openssh-server`) and make sure the server is reachable over the local internet. 
5. Install Github CLI (gh). Add the library and install with apt rather than installing another package manager: https://www.techiediaries.com/install-github-cli-ubuntu-20/
6. Authenticate with Github (`gh auth login`) with SSH, using a personal access token. Create in settings > developer settings > personal access token. It needs workflow, admin::publickey, and read::org privs.
7. Set up Portainer. Ensure that the container is running successfully, then allow the port through the ubuntu firewall (ufw) and check it's visible from another computer on the same network.
8. Set up Grafana and Prometheus. Since there is a circular network dependency for them, you might need to re-run the commands until all the dependencies are set up or create the networks ahead of time. Dependencies are like grafana <--> prometheus --> minecraft. 
9. Verify Prometheus is reachable on port 9090. Check that status > targets shows items as green.
10. Verify Grafana is reachable on port 3000. Log in as admin:admin (default creds) and change the admin password. Create a new Grafana data source to read from Prometheus (see whitney/grafana for more) and import the dashboard with id `1860` as a starting point.
11. Set up Jenkins. Reset the admin password and configure any jobs that templates have been saved for.
12. Set up CertBot. Generate certs for all websites we want to have certs for.
13. Set up Nginx. Make sure any dependent website repos are cloned to /var/www/html/ (made by first unsuccessful run of nginx, or manually)
