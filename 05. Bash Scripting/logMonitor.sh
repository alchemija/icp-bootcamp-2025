#!/bin/bash

#objective: monitor a logfile in real time and alert the user if a specific keyword is found & includes a throttle mechanism
#this script also checks at how many instances there were of the keyword during the throttle period

log_file="test.txt"        # path to the log file
keyword="error"            # keyword to monitor
throttle_seconds=10        # time in seconds to throttle alerts

#when was the user last alerted
last_notification_time=0

#how many times the tracked keyword was found during the throttle period
error_count=0

pending_notification=false

if [ ! -f "$LOGFILE" ]; then
    echo "error: log file '$LOGFILE' does not exist."
    exit 1
fi

tail -F "$log_file" | while read -r line; do
    current_time=$(date +%s)
    time_diff=$((current_time - last_notification_time))

    #check for pending notifications from previous throttle period
    if [ "$pending_notification" = true ] && [ $time_diff -ge $throttle_seconds ]; then
        echo "ALERT: found $error_count occurrence(s) of '$keyword' during throttle period"
        error_count=0
        pending_notification=false
        last_notification_time=$current_time
    fi

    #check if current line contains keyword
    if echo "$line" | grep -i "$keyword" > /dev/null; then
        #if enough time has passed since last notification
        if [ $time_diff -ge $throttle_seconds ]; then
            echo "ALERT: found occurrence of '$keyword' in $log_file"
            error_count=0
            last_notification_time=$current_time
            pending_notification=false
        else
            #inside throttle period
            error_count=$((error_count + 1))
            #if this is the first error in this throttle period
            if [ $error_count -eq 1 ]; then
                echo "ALERT: Found '$keyword' in $log_file. Further notifications will be throttled for $throttle_seconds seconds."
            fi
            pending_notification=true
        fi
    fi
done
