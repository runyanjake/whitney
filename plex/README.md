# Plex 

A self hosted plex server that is basically the vanilla plex docker container.

Build Container:

`docker build -t whitney/node_whitney .`

Run Container:

docker run -d --name=plex_whitney --net=host -e PUID=1000 -e PGID=1000 -e VERSION=docker -e PLEX_CLAIM= `#optional` -v /data/plex/library:/config -v /data/plex/tvseries:/tv -v /data/plex/movies:/movies -v /data/plex/transcode:/transcode --restart always ghcr.io/linuxserver/plex

