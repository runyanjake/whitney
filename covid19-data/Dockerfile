# using ubuntu 20.04
FROM ubuntu:20.04

# copy files
COPY ./data.sh /etc/data.sh
COPY ./docker-credentials.txt /etc/docker-credentials.txt
COPY ./cronjob /etc/cron.d/covid-data-cronjob

# install cron
RUN apt-get update && apt-get install cron -y && apt-get install vim -y

# Give executable
RUN chmod +x /etc/data.sh

# Container startup cron stuff
CMD [“/bin/bash”, “-c”, “/script.sh && chmod 644 /etc/cron.d/covid-data-cronjob && cron && tail -f /var/log/cron.log”]