# Author @runyanjake
# Downloads covid counts and populates a database with new information.

# check usage and set debug mode
DEBUG=0
while getopts "d" OPTIONS
do
    case $OPTIONS in
	d)
	    echo "Enabling debug mode."
	    DEBUG=1 
    esac
done
if [ "$#" -gt 1 ]; then
    echo "Usage: data.sh [-d(ebug mode)]"
fi

# Constants (In case things change)
recent_counts_filename=us-counties-recent.csv
all_counts_filename=us-counties.csv
sql_filename=tmp.sql

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
# TODO

# Run mysql instructions
# TODO can use awk to read values from a credentials file.

# Create dump of database and save last 3 dumps locally.
#TODO

# Cleanup
echo "Cleaning up..."
rm us-counties-recent.csv 2> /dev/null
rm us-counties.csv 2> /dev/null
rm tmp.sql 2> /dev/null
echo -e "\e[1A\r\e[KCleaning up... Done."

echo "Finished. Exiting..."

