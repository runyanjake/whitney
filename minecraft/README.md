# Whitney Minecraft

PWS hosted Minecraft server. Based off of https://github.com/nimmis/docker-spigot. 
</br>
Data stored on disk rather than docker volume so things like the config can be edited via just ssh. 
</br>
Good practice to give the container names like minecraft_whitney_1.17 for versioning/if we want to reroll servers.
</br>
Monitoring commands to get logs from the container are documented in the github repo.

### Start with Docker Compose

`docker-compose up -d`

### Start with Plain Docker

`docker run -d -p 25565:25565 --network=host --restart=always --name=minecraft_whitney -e EULA=true -e MC_MAXMEM=2g -e MC_MINMEM=512m -v ./minecraft:/minecraft nimmis/spigot`

