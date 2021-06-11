# Redirect http traffic to https
server { 
	listen		80;
	listen		[::]:80;
	server_name	www.jakeswestcoast.com jakeswestcoast.com;
	return 		301 https://jakeswestcoast.com$request_uri;
}

# Default jakeswestcoast.com
server {
	listen			443 ssl;
	listen			[::]:443 ssl;
	ssl_certificate 	/data/certbot/live/jakeswestcoast.com/fullchain.pem;
	ssl_certificate_key	/data/certbot/live/jakeswestcoast.com/privkey.pem;

	root /var/www/html/jakeswestcoast.com;
	index index.html;
	server_name www.jakeswestcoast.com jakeswestcoast.com;

	location / {
		try_files $uri $uri/ =404;
	}
}

# Rides subdomain
server {
	listen			443 ssl;
	listen			[::]:443 ssl;
	ssl_certificate 	/data/certbot/live/jakeswestcoast.com/fullchain.pem;
	ssl_certificate_key	/data/certbot/live/jakeswestcoast.com/privkey.pem;

	root /var/www/html/jakeswestcoast.com/rides;
	index index.html;
	server_name rides.jakeswestcoast.com;

	location / {
		try_files $uri $uri/ =404;
	}
}
