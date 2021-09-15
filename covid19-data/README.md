# Covid 19 Data Gatherer

### Files
 - daily/data_collection_1d.sh - Main runner of all daily collection tasks.
 - daily/0000_chop_counts.sh - Removes previous days' data from covid counts file(s).
 - daily/0001_blacklist.sh - Removes lines with blacklisted county/state/etc names (since other data for them is not available.)
 - daily/0002_replace.sh - Replaces unparseable characters with ones we can deal with.

### daily/data_collection_1d.sh

Main runner of all daily collection tasks.
</br>
1. Makes sure required files are there. e.g. mysql credentials file
</br>
2. Cleans working directory. Removes the downloaded counts files and tmp sql file.
</br>
3. Downloads covid counts.
</br>
4. Delegates to other scripts to sanitize covid counts.
</br>
5. Delegates to other scripts to build sql file.
</br>
6. Runs sql file with available credentials.
</br>
7. Creates a dump of the database for safekeeping. Deletes extra dumps.
</br>
8. Cleans up after itself.

### daily/0000_chop_counts.sh

Removes previous days' data from covid counts file(s).

### daily/0001_blacklist.sh

Removes lines with blacklisted county/state/etc names (since other data for them is not available.)

### 0002_replace.sh

Replaces unparseable characters with ones we can deal with.