# Whitney Minecraft

This is my self hosted Spigot minecraft server. Based off of https://github.com/nimmis/docker-spigot. 
</br>
Before running may need to create a `minecraft` directory in this folder. idk if docker will know to create it.

### Start with Docker Compose

`docker-compose up -d`

### Start with Plain Docker

`docker run -d -p 25565:25565 --network=host --restart=always --name=minecraft_whitney -e EULA=true -e MC_MAXMEM=2g -e MC_MINMEM=512m -v ./minecraft:/minecraft nimmis/spigot`

