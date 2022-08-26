# Plex 

A self hosted plex server that is basically the vanilla plex docker container.

### Requirements

The container expects its mounted folders to exist already, before it's created. 
Either create the following or mount a drive to /data/plex that has your data.
- `/data/plex/tvseries`
- `/data/plex/movies`
- `/data/plex/photos`
- `/data/plex/homevideos`
- `/data/plex/transcode`

(If Docker has been installed with snap, while installing the OS, you'll have issues here. It's better to seperately install docker-ce and docker-compose.

### Start with Docker Compose:

`docker-compose up -d`

### Start with Plain Docker

`docker run -d --name=plex_whitney --net=host -e PUID=1000 -e PGID=1000 -e VERSION=docker -e PLEX_CLAIM= `#optional` -v /data/plex/library:/config -v /data/plex/tvseries:/tv -v /data/plex/movies:/movies -v /data/plex/transcode:/transcode --restart always ghcr.io/linuxserver/plex`

### Notes

When navigating to plex, assuming no nginx routing is happening, you must go to `http://[ip address]:32400/web/index.html#!/` for first time setup. Just going to port 32400 doesn't work for some reason until after the setup is complete.
