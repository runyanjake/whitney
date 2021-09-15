#!/bin/bash
# 0001_blacklist.sh
# Author @runyanjake @kevrunamok
# Remove lines that have blacklisted words.

# check usage
if [ "$#" -ne 1 ]; then 
    echo "Usage: 0001_blacklist.sh <counts_filename>"
fi