#!/bin/bash

#objective: create a script that displays the size of a given directory in human readable format

#get the absolute path of the directory
DIR_PATH=$(realpath "$1" 2>/dev/null)

#check if the directory exists
if [ -d "$DIR_PATH" ]; then
    #display the size of the directory in human-readable format
    echo "$DIR_PATH is $(du -sh | cut -f1)"
else
    echo "error: directory '$DIR_PATH' does not exist."
    exit 1
fi
