#!/bin/bash
# data_collection_7d.sh
# Author @runyanjake
# Updates a database with new information on a weekly basis.

# check usage and set debug mode
if [ "$#" -gt 0 ]; then
    echo "Usage: data.sh "
fi

# Constants (In case things change)
mysql_credentials_filename=mysql-credentials.txt
recent_counts_filename=us-counties-recent.csv
all_counts_filename=us-counties.csv
sql_filename=tmp.sql

# Read credentials file.
echo "Reading MySQL credentials file..."
if [[ ! -e $mysql_credentials_filename ]]; then
    echo "No mysql credentials file exists. Please create $mysql_credentials_filename with the form"
    echo "mysql_host mysql_port mysql_user mysql_pass"
    echo "Exiting with failure code..."
    exit 1
fi
mysql_host=$(awk '{print $1}' $mysql_credentials_filename)
mysql_port=$(awk '{print $2}' $mysql_credentials_filename)
mysql_user=$(awk '{print $3}' $mysql_credentials_filename)
mysql_pass=$(awk '{print $4}' $mysql_credentials_filename)
echo -e "\e[1A\r\e[KReading MySQL credentials file... Done."

# Prepare working directory by removing any straggler files.
echo "Preparing working directory..."
rm us-counties-recent.csv 2> /dev/null
rm us-counties.csv 2> /dev/null
rm tmp.sql 2> /dev/null
echo -e "\e[1A\r\e[KPreparing working directory... Done."

# Downloads Last 6mo of covid counts 
# If more than 6mo are needed we can download master/us-counties.csv.
# Implements exponential backoff if the file fails to download
echo "Downloading covid counts..."
curl -LJO http://raw.githubusercontent.com/nytimes/covid-19-data/master/$recent_counts_filename 2> /dev/null
echo -e "\e[1A\r\e[KDownloading covid counts... Done."
retry_limit=10
itor=1
while [ ! -e $recent_counts_filename ] && [ $retry_limit -ge $itor ]
do
    sleep $((1 + 3*(itor-1)*(itor-1)))
    if [[ $itor -gt 1 ]]; then
        echo -e "\e[1A\r\e[KFailed to download covid counts. Retry attempt $itor/$retry_limit..."
    else
        echo -e "Failed to download covid counts. Retry attempt $itor/$retry_limit..."
    fi
    curl -LJO http://raw.githubusercontent.com/nytimes/covid-19-data/master/$recent_counts_filename 2> /dev/null
    if [[ -e $recent_counts_filename ]]; then
        echo "Successfully downloaded covid counts after $itor attempts."
    fi
    itor=$((itor + 1))
done
if [[ ! -e $recent_counts_filename ]]; then
    echo "Failed to download covid counts after multiple retries. Exiting due to failure..."
    exit 1
fi

# Sanitize covid counts
# TODO

# Build mysql instructions
touch $sql_filename
# TODO

# Run mysql instructions
echo "Executing MySQL instructions..."
mysql -u$mysql_user -p$mysql_pass -h$mysql_host -P$mysql_port < $sql_filename 2> /dev/null
echo -e "\e[1A\r\e[KExecuting MySQL instructions... Done."

# Create dump of database and save last 3 dumps locally.
echo "Creating a dump of the database..."
rm -r ./logs
mkdir logs
mysql_dump_name=./logs/mysql_$(date -d "today" +"%Y%m%d%H%M").log
mysqldump -u$mysql_user -p$mysql_pass -h$mysql_host -P$mysql_port > $mysql_dump_name 2> /dev/null
echo -e "\e[1A\r\e[KCreating a dump of the database... Done."

# Cleanup
echo "Cleaning up..."
rm us-counties-recent.csv 2> /dev/null
rm us-counties.csv 2> /dev/null
rm tmp.sql 2> /dev/null
echo -e "\e[1A\r\e[KCleaning up... Done."

echo "Finished. Exiting..."

