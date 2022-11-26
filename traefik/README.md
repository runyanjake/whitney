# Traefik

I got recommended Traefik over Nginx for its ease of use and service discovery.

For setup I followed this official Traefik tutorial: https://doc.traefik.io/traefik/getting-started/quick-start/

`https://doc.traefik.io/traefik/user-guides/docker-compose/basic-example/` is also a good reference.

### Baby Steps Setup

##### Step 1

1. Run `step1-docker-compose.yml`

`docker-compose -f step1-docker-compose.yml up -d`

2. Test by curl

`curl http://localhost:8080/api/rawdata`

3. Stop all and prune

`docker stop step1-traefik`

`docker system prune`

##### Step 2

1. Run `step2-docker-compose.yml`

`docker-compose -f step2-docker-compose.yml up -d`

2. Test by curl

`curl -H Host:whoami.docker.localhost http://127.0.0.1`

3. Stop all and prune

`docker stop step2-traefik step2-whoami`

`docker system prune`

##### Step 3

1. Run `step3-docker-compose.yml`

`docker-compose -f step3-docker-compose.yml up -d`

2. Test by curl

`curl http://whoami.whitney.rip`

3. Stop all and prune

`docker stop step3-traefik step3-whoami`

`docker system prune`

### Actual Traefik Setup

##### Step 1: Basic Traefik

Starting with the basic example: `https://doc.traefik.io/traefik/user-guides/docker-compose/basic-example/`

1. Change basic things like names of containers, routing host for the example service.

2. Add a traefik-specific network for the containers to communicate over. Other containers outside of this config file can reference it so that Traefik can discover and send requests to them internally.

3. Run, and test that the whoami container gives its response back correctly.

4. Then, configure other containers to be discovered off of Traefik by adding the basic labels: `traefik.enable`, `traefik.http.routers.container_name.rule`, and `traefik.http.routers.container_name.entrypoints`. 






### Some old notes from when I tried TLS stuff.

Followed this tutorial: `https://doc.traefik.io/traefik/user-guides/docker-compose/acme-dns/`.

Providers list for Traefik: `https://doc.traefik.io/traefik/https/acme/#providers`.

1. Update `docker-compose-BLANKED.yml` with the correct values and copy it to `docker-compose.yml`.

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

4. Check that the api is working.

Visit `http://YOUR_IP_HERE:8080/dashboard`

### Additional Steps

1. Convert to a static Traefik configuration (seems better)

Create `traefik.toml` and edit the `docker-compose.yml` to ensure that it's copied to one of the searched directories (I chose `/etc/traefik/`)

The conversion from env vars to `traefik.toml` is really easy - each one of them is basically describing one attribute of the yaml, so basically just build the yaml from those attributes.

2. Start to secure the Traefik Dashboard.

Generate a password with `htpasswd` (`https://doc.traefik.io/traefik/middlewares/http/basicauth/`)

Example using BCrypt: `https://unix.stackexchange.com/questions/307994/compute-bcrypt-hash-from-command-line`. See this thread about Traefik not liking the `$` character: `https://github.com/DeviaVir/zenbot/issues/2663`





