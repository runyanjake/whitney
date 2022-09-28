# Nginx Test Setup

Test files to verify that nginx is working on the server and that cloudflare is correctly set up for providing DNS records for the server.

### Part 1: Basic Nginx.

Run the contianer 

`docker-compose up -d` to start `step1-test-nginx-whitney`.

Verify that it worked via curl.

`curl -vvv 192.168.1.136:80`


