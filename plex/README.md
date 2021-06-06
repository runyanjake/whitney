# Plex 

A self hosted plex server that is basically the vanilla plex docker container.

### Start with Docker Compose:

`docker-compose up -d`

### Start with Plain Docker

`docker run -d --name=plex_whitney --net=host -e PUID=1000 -e PGID=1000 -e VERSION=docker -e PLEX_CLAIM= `#optional` -v /data/plex/library:/config -v /data/plex/tvseries:/tv -v /data/plex/movies:/movies -v /data/plex/transcode:/transcode --restart always ghcr.io/linuxserver/plex`

