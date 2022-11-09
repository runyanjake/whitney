# Traefik

I got recommended Traefik over Nginx for its ease of use and service discovery.

For setup I followed this official Traefik tutorial: https://doc.traefik.io/traefik/getting-started/quick-start/

### Step 1

1. Run `step1-docker-compose.yml`

`docker-compose -f step1-docker-compose.yml up -d`

2. Test by curl

`curl http://localhost:8080/api/rawdata`

3. Stop all and prune

`docker stop step1-traefik`

`docker system prune`

### Step 2

1. Run `step2-docker-compose.yml`

`docker-compose -f step2-docker-compose.yml up -d`

2. Test by curl

`curl -H Host:whoami.docker.localhost http://127.0.0.1`

3. Stop all and prune

`docker stop step2-traefik step2-whoami`

`docker system prune`

### Step 3

1. Run `step3-docker-compose.yml`

`docker-compose -f step3-docker-compose.yml up -d`

2. Test by curl

`curl http://whoami.whitney.rip`

3. Stop all and prune

`docker stop step3-traefik step3-whoami`

`docker system prune`

### Actual Traefik Setup

Mainly followed this tutorial: https://doc.traefik.io/traefik/user-guides/docker-compose/acme-tls/ (Still not sure which of these to use at the moment, there are issues generating a new cert with the bundled Let's Encrypt.)

But there was an issue with certs, which i fixed by providing certs.json as instructed here: https://www.digitalocean.com/community/tutorials/how-to-use-traefik-as-a-reverse-proxy-for-docker-containers-on-ubuntu-18-04

##### Notes

The admin password isn't checked in to github so make sure to generate it with htpasswd and put it into traefik.toml.

`htpasswd -nb user password`

Form is user:encrypted_password.

Some notable changes from the example: 

- Docker network name is `traefik`, not `web`.

- Let's Encrypt data is getting stored in `certs.json`, not `acme.json`.

### Running the container

1. Create the LetsEncrypt secret file if not exists.

`touch certs.json`

`chmod 600 certs.json`

2. Start the container

`docker-compose up -d`

