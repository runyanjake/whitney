# Covid 19 App

Covid 19 app from `https://github.com/KevRunAmok/Covid19app` & dockerized by me to build both the app and the dependancy mysql container.
</br>
Clone the app repo and build the image from a dockerfile, and then run the container.
</br>
You might need to create a data folder that the volume goes into.
</br>
If a data file is available you can add it in the `schema` folder. It will be copied over by docker-compose and mysql will pick it up and execute it.
</br>
NOTE: Mysql seems to only execute the create_schema.sql file. Any data files have to be executed after the fact by being piped into mysql.
</br>
</br>
The mysql container needs a new user created after the fact.
</br>
`docker exec -it mysql_whitney mysql -uroot -proot`
</br>
`CREATE USER 'kr_covid'@'%' IDENTIFIED BY 'kr_covid';`
</br>
`ALTER USER 'kr_covid'@'%' IDENTIFIED WITH mysql_native_password BY 'covid123';`
</br>
Execute `create_schema.sql` if the tables didn't show up. This happened from time to time in testing.
</br>
</br>
These containers communicate over the mysql-network network instead of host networking.
