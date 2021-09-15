#!/bin/bash
# 0000_chop_counts.sh
# Author @runyanjake
# Chops old counts from the file.

# check usage
if [ "$#" -ne 1 ]; then 
    echo "Usage: 0000_chop_counts.sh <counts_filename>"
fi

last_date_processed_filename=last_date.txt
counts_filename=$1
shortened_counts_filename="new_counts.tmp"

if [[ ! -e $last_date_processed_filename ]]; then
    echo "No file $last_date_processed_filename. Needed to run."
    exit 1
fi

if [[ ! -e $counts_filename ]]; then
    echo "No file $counts_filename. Needed to run."
    exit 1
fi

# Cut off previous days we won't process. We need to include the last processed day too for the sake of lookback.
last_date_processed=$(cat $last_date_processed_filename) 
awk_command="awk -F \",\" '/$last_date_processed/ {print NR; exit}' $counts_filename"
bookmark_line_number=$(eval $awk_command)
echo "Last date processed was $last_date_processed. This corresponds to line $bookmark_line_number in the data file."
echo "We will grab data from that day onward for the sake of lookback."
tail -n +$bookmark_line_number $counts_filename > $shortened_counts_filename

# Unused but useful for date math.
# nextday_command='date +%Y-%m-%d -d "$last_date_processed + $i day"'
# date_to_process_from=$(eval $nextday_command)