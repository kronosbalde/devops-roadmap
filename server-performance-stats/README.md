# system-monitor.sh

A lightweight Bash script that displays real-time system metrics directly from the Linux kernel's virtual filesystem — no external tools required.

## What it does

Reads raw data from `/proc/stat` and displays a live dashboard that refreshes every second in the terminal.

Currently tracked metrics:

- **CPU usage** — calculated as the delta between two `/proc/stat` samples over a 1-second interval
- **RAM usage** — calculated using `/proc/meminfo` samples

More metrics (RAM, disk) are planned and will be added as separate functions.

## How it works

The script takes two snapshots of `/proc/stat` one second apart, computes the difference in CPU time across all states (user, system, idle, iowait, etc.), and derives the usage percentage from that delta.
For RAM usage, the script reads `/proc/meminfo` and extracts `MemTotal` and `MemAvailable`. Used RAM is calculated as the difference between the two, and the usage percentage is derived from that. All values are converted from kB to MB for readability.

## Usage
```bash
chmod +x system-monitor.sh
./system-monitor.sh
```

Press `Ctrl+C` to exit.

## Requirements

- Bash
- Linux kernel (reads `/proc/stat`)
- Linux kernel (reads `/proc/meminfo`)
- No external dependencies
