#!/usr/bin/env bash
# system-monitor.sh

get_cpu_usage() {
    read -r _ user1 nice1 system1 idle1 iowait1 irq1 softirq1 _ < /proc/stat
    sleep 1
    read -r _ user2 nice2 system2 idle2 iowait2 irq2 softirq2 _ < /proc/stat

    local idle_delta=$(( (idle2 + iowait2) - (idle1 + iowait1) ))
    local total_delta=$(( (user2 + nice2 + system2 + idle2 + iowait2 + irq2 + softirq2) \
                        - (user1 + nice1 + system1 + idle1 + iowait1 + irq1 + softirq1) ))

    echo $(( 100 * (total_delta - idle_delta) / total_delta ))
}

print_dashboard() {
    local cpu
    cpu=$(get_cpu_usage)

    clear
    echo "================================"
    echo "       SYSTEM MONITOR           "
    echo "================================"
    echo " CPU Usage : ${cpu}%"
    echo "================================"
    echo " [Ctrl+C to exit]"
}

while true; do
    print_dashboard
done
