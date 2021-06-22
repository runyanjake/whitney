# Covid 19 App

Covid 19 app from `https://github.com/KevRunAmok/Covid19app` & dockerized by me to build both the app and the dependancy mysql container.
</br>
Clone that repo and copy the relevant files into the same directory as docker-compose.yml before moving on.
</br>
A few inital setup steps need to be taken if building the container from scratch. (see below)
</br>
Also make sure that the `./schema` folder is created with sql to create the database and populate data.
</br>
Note: If mysql can't start due to `Another process with pid 30 is using unix socket file`, this is likely because the socket file was locked when the container was last shut down. It persists to `/data/covid19/mysql.sock.lock` so removing this should fix the issue.

### Build Image With Docker

`docker build --tag="kr/covid_whitney" .`

### Start with Docker-Compose

Creates the mysql container, the covid container, and a shared network they communicate on.
</br>
`docker-compose up -d`

### Start with Plain Docker (Just the Covid App)

Build the image with:
</br>
`docker build --tag="kr/covid_whitney" .`
</br>
Run the image with: 
</br>
`docker run -d --name="covid_whitney" --network=mysql-network --restart=always -p 1337:1337 kr/covid_whitney`
</br>
Note: this requires the mysql-network. If not created already create it with:
</br>
`docker network create mysql-network`

## Container Setup Steps

1. Execute the setup script if it was not auto-run. This sets up the mysql schema.
You'll have provided the .sql file in your ./data folder. It's copied to /docker-entrypoint-initdb.d/ and you can run while exec'd onto the container.
2. Create a user who can query the tables.
- `docker exec -it mysql_whitney mysql -uroot -proot`
- `select * from mysql.user;`
- `CREATE USER 'kr_covid'@'%' IDENTIFIED BY 'kr_covid';`
- `ALTER USER 'kr_covid'@'%' IDENTIFIED WITH mysql_native_password BY 'covid123';`
- After adding this user you can exec onto the container and run mysql from there.
3. Import any data. (Note this step must be done each time the databases is wiped - aka when the persistant folder /data/covid19/mysql is deleted.)
If you specified it in `./schema` it'll also be copied into `/docker-entrypoint-initdb.d/`

