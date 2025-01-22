#!/bin/bash

#objective: create a script that lists all files in a given directory modified in the last x days

#check if sufficient arguments are provided
if [ "$#" -ne 2 ]; then
    echo "usage: $0 <directory_path> <days>"
    exit 1
fi

DIRECTORY=$1
DAYS=$2

#check if the directory exists
if [ ! -d "$DIRECTORY" ]; then
    echo "Error: Directory '$DIRECTORY' does not exist."
    exit 1
fi

#get the current date
CURRENT_DATE=$(date +%s)

echo "files in '$DIRECTORY' modified in the last $DAYS days:"

#loop through each file in the directory
for FILE in "$DIRECTORY"/*; do

    #get the last modification time of the file in seconds since epoch
    MOD_TIME=$(stat -c %Y "$FILE")

    #calculate the age of the file in days
    AGE_DAYS=$(( (CURRENT_DATE - MOD_TIME) / 86400 ))

    #check if the file was modified in the last X days
    if [ "$AGE_DAYS" -le "$DAYS" ]; then
      echo "$FILE"
    fi
done

