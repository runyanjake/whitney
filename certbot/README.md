# Certbot for Whitney

Creates an instance of Certbot that can generate certificates signed by LetsEncrypt & communicate them to Cloudflare via TXT records.
Provide cloudflare information in ./cloudflare.ini and a data folder will be created that will contain certificates. (It's recommended to make the file read only and the containing folder read/write/execute for privacy.
</br>
Create a cloudflare api key for certbot and put it in cloudflare.ini if the old one has expired.
</br>
References: 
- https://certbot-dns-cloudflare.readthedocs.io/en/stable/
- https://certbot-dns-cloudflare.readthedocs.io/_/downloads/en/latest/pdf/
</br>
Note that this doesn't run in the background by default and may take some time to finish.

### Start with Docker-Compose

Choose a docker compose file and rename it to docker-compose.yml
</br>
You also might need to copy a nginx config in here although it's doesn't need to be the actual one in use.
</br>
`docker-compose up`
(don't use -d since there may be errors.)

