version: "3"
services:
  covid-data:
    image: kr/covid_whitney_data
    container_name: covid_data_whitney
    restart: always
    depends_on:
      - mysql
    networks:
      mysql-network

