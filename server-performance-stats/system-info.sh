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

get_ram_usage() {
    local total available used percent

    total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    available=$(grep MemAvailable /proc/meminfo | awk '{print $2}')

    used=$(( total - available ))
    percent=$(( used * 100 / total ))

    # Restituisce 4 valori su una riga separati da ":"
    echo "$(( total / 1024 )):$(( used / 1024 )):$(( available / 1024 )):${percent}"
}

get_top_processes() {
    ps aux --sort=-%cpu | awk 'NR>1 {printf "%-25s %s%%\n", $11, $3}' | head -5
}


print_dashboard() {
    local cpu ram_raw
    local ram_total ram_used ram_free ram_percent

    cpu=$(get_cpu_usage)
    ram_raw=$(get_ram_usage)

    # Split 4 values using ":"
    IFS=':' read -r ram_total ram_used ram_free ram_percent <<< "$ram_raw"

    clear
    echo "================================"
    echo "       SYSTEM MONITOR           "
    echo "================================"
    echo " CPU Usage  : ${cpu}%"
    echo "--------------------------------"
    echo " RAM Total  : ${ram_total} MB"
    echo " RAM Used   : ${ram_used} MB"
    echo " RAM Free   : ${ram_free} MB"
    echo " RAM Usage  : ${ram_percent}%"
    echo "================================"
    echo " TOP 5 PROCESSES (CPU)"
    echo "--------------------------------"
    get_top_processes
    echo "--------------------------------"
    echo " [Ctrl+C to exit]"
}

while true; do
    print_dashboard
done