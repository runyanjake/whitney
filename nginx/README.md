# Nginx

Nginx instance that routes traffic for both www.whitney.rip and www.runyan.dev. Handles https upgrading, and all subdomains for each domain.

### Build Image With Docker Compose

docker-compose up -d

### Notes

Expects the folder `./sites-enabled` to hold a folder for each domain's nginx config. This is copied into `/etc/nginx/sites-enabled` on the docker container. The main nginx conf is here and is copied into `/etc/nginx/nginx.conf`.
</br>
Expects html in `/var/www/html/` (folder for each domain). This is copied into the same location on the docker container and is referenced in the individual nginx configs.
</br>
Expects that certbot has been run and has stored its output in /data/certbot. The individual nginx configs will read from there.

