# whitney-node
Dockerized node app from https://github.com/runyanjake/node_whitney that runs on www.node.whitney.rip. 
Clone the repo and copy files into this folder before building.

### Build Image With Docker

`docker build -t whitney/node_whitney .`

### Start Container With Docker-Compose

`docker-compose -up -d`

### Start Container With Plain Docker

`docker run -d --name="node_whitney" --restart=always -p 8081:8081 whitney/node_whitney`

