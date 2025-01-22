#!/bin/bash


#function to display system information
show_system_info() {
    #memory (gets printed with text already)
    free -h

    echo -e "\nCPU: $(top -bn1 | grep "Cpu(s)")"

    echo -e "\nDisk Space: \n$(df -h | sed 1d)"

    echo -e "\nNetwork:"
    for iface in $(ip -o link show | awk -F': ' '{print $2}'); do
        rx_bytes=$(cat /sys/class/net/$iface/statistics/rx_bytes)
        tx_bytes=$(cat /sys/class/net/$iface/statistics/tx_bytes)
        echo "$iface: RX: $rx_bytes bytes, TX: $tx_bytes bytes"
    done
}

#function to save snapshot to file
save_snapshot() {
    local SNAPSHOT_FILE="system_snapshot_$(date +"%Y%m%d%H%M%S").txt"
    echo "Saving snapshot to $SNAPSHOT_FILE..."
    {
        echo "===== System Snapshot - $(date) ====="
        show_system_info
    } > "$SNAPSHOT_FILE"
    echo "Snapshot saved!"
}

#main loop to monitor system resources
while true; do
    clear
    show_system_info

    echo -e "\nPress 's' to save snapshot, 'q' to quit."

    #wait for user input (with a short timeout)
    read -t 1 -n 1 user_input

    if [[ "$user_input" == "s" ]]; then
        save_snapshot
    elif [[ "$user_input" == "q" ]]; then
        echo "Exiting..."
        break
    fi
done
