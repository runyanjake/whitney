# using ubuntu 20.04
FROM ubuntu:20.04

# copy files
COPY ./daily /etc/daily
COPY ./weekly /etc/weekly
COPY ./cronjob /etc/cron.d/covid-data-cronjob

# install cron
RUN apt-get update && apt-get install cron -y && apt-get install vim -y

# Give executable
RUN chmod +x /etc/data.sh

# Container startup cron stuff
CMD [“/bin/bash”, “-c”, “/script.sh && chmod 644 /etc/cron.d/covid-data-cronjob && cron && tail -f /var/log/cron.log”]
