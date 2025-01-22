#!/bin/bash

#objective: create a script that backs up a specified directory to another location, mainains versioning by appending timestamps to backups, automatically deletes the oldest backup if the number of backups exceeds a defined limit & support full & incremental backups, based on user input

BACKUP_LIMIT=5  #max number of backups to retain
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

#full backup function
full_backup() {
    local src="$1"
    local dest="$2"
    local backup_dir="${dest}/backup_${TIMESTAMP}_full"

    echo "starting full backup of $src to $backup_dir..."

    mkdir -p "$backup_dir"

    cp -r "$src"/* "$backup_dir"

    echo "full backup finished: $backup_dir"
}

#incremental backup function
incremental_backup() {
  local src="$1"
  local dest="$2"
  local last_backup_dir=$(ls -td "${dest}"/backup_* | head -n 1)
  local backup_dir="${dest}/backup_${TIMESTAMP}_incremental"

  if [ -z "$last_backup_dir" ]; then
    echo "no previous backup found, doing a full backup instead."
    full_backup "$src" "$dest"
    return
  fi

  echo "starting incremental backup of $src to $backup_dir..."

  mkdir -p "$backup_dir"

  # use rsync to copy only changed files
  rsync -a --compare-dest="$(realpath "$last_backup_dir")" "$src"/ "$backup_dir"

  echo "incremental backup finished: $backup_dir"
}

#function to remove old backups if needed
cleanup_old_backups() {
    local dest="$1"
    local backups=($(ls -td "${dest}"/backup_*))
    local num_backups=${#backups[@]}

    # check if there are too many backups
    if (( num_backups > BACKUP_LIMIT )); then
        local num_to_delete=$(( num_backups - BACKUP_LIMIT ))
        echo "too many backups, deleting $num_to_delete old one(s)..."

        for (( i=0; i<num_to_delete; i++ )); do
        echo "deleting: ${backups[$((num_backups-1-i))]}"
        rm -rf "${backups[$((num_backups-1-i))]}"
        done
    else
        echo "no backups to delete, total backups: $num_backups"
    fi
}

#main script starts here
if [ "$#" -lt 3 ]; then
    echo "usage: $0 <full|incremental> <source_directory> <destination_directory>"
    exit 1
fi

BACKUP_TYPE="$1"
SOURCE_DIR="$2"
DEST_DIR="$3"

#check if source exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "error: source directory '$SOURCE_DIR' doesn't exist."
    exit 1
fi

#check if destination exists
if [ ! -d "$DEST_DIR" ]; then
    echo "error: destination directory '$DEST_DIR' doesn't exist."
    exit 1
fi

#run the backup based on user input
case "$BACKUP_TYPE" in
    full)
        full_backup "$SOURCE_DIR" "$DEST_DIR"
        ;;
    incremental)
        incremental_backup "$SOURCE_DIR" "$DEST_DIR"
        ;;
    *)
        echo "error: invalid backup type. use 'full' or 'incremental'."
        exit 1
        ;;
esac

#clean up old backups
cleanup_old_backups "$DEST_DIR"

echo "backup completed successfully."
