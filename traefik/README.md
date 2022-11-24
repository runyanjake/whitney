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

Followed this tutorial: `https://doc.traefik.io/traefik/user-guides/docker-compose/acme-dns/`.

Providers list for Traefik: `https://doc.traefik.io/traefik/https/acme/#providers`.

1. Update `docker-compose.yml` with the correct values.

`EMAIL@ME.COM`

`CLOUDFLARE@EMAIL.COM`

`API_KEY`

`MYDOMAIN.COM`

2. Run `docker-compose.yml`

`docker-compose up -d`

3. Test by curl, then on browser.

`curl -vvv https://whitney.rip`

If certificate is not right, can probably debug from the curl response.

Try `https://whitney.rip` in browser, should see the curl response in html.

Running the container will generate the following structure:

`letsencrypt/`

|--> `acme.json`
