#!/bin/bash

#objective: create a backup script to backup directories

#check if enough arguments are provided
if [ "$#" -lt 2 ]; then
    echo "usage: $0 <backup_directory> <dir1> <dir2> ... <dirN>"
    exit 1
fi

BACKUP_DIR=$1
shift #using shift so the for loop doesn't back up the backup dir

#creating the backup directory if it does not exist
mkdir -p "$BACKUP_DIR"

#loop through the list of directories
for DIR in "$@"; do
    if [ -d "$DIR" ]; then
        #create a backup of the directory
        BASENAME=$(basename "$DIR")
        cp -r "$DIR" "$BACKUP_DIR/$BASENAME"
        if [ $? -eq 0 ]; then
            echo "successfully backed up '$DIR' to '$BACKUP_DIR/$BASENAME'"
        else
            echo "error: failed to backup '$DIR'."
        fi
    else
        echo "error: directory '$DIR' does not exist."
    fi
done
