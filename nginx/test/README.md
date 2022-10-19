# Nginx Test Setup

Test files to verify that nginx is working on the server and that cloudflare is correctly set up for providing DNS records for the server.

### Part 1: Basic Nginx.

Run the contianer 

`docker-compose -f step1-docker-compose.yml up -d` to start `step1-test-nginx-whitney`.

Verify that it worked via curl on another computer connected to the same network.

`curl -vvv 192.168.1.136:80`

Stop the container & clean up.

`docker stop step1-test-nginx-whitney`

`docker system prune`


### Part 2: Hello Cloudflare

Find public IP and configure Cloudflare DNS for the website.

Run the container

`docker-compose -f step2-docker-compose.yml up -d` to start `step2-test-nginx-whitney`.i

Verify that it worked on another computer connected to the same network at `https://www.whitney.rip`.

