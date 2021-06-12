# Whitney Minecraft

PWS hosted Minecraft server. Based off of `https://github.com/itzg/docker-minecraft-server` since nimmis/spigot was not updated to use a java version compatible with minecraft 1.17+.
</br>
Data stored on disk rather than docker volume so things like the config can be edited via just ssh. 
### Start with Docker Compose

`docker-compose up -d`

### Start with Plain Docker

`docker run -d -p 25565:25565 --restart=always -e TYPE=SPIGOT --name=minecraft2_whitney -e EULA=TRUE -v /data/minecraft2:/data -v ./server.properties:/data/server.properties itzg/minecraft-server`

### Useful Commands
`docker logs -f container_name`

