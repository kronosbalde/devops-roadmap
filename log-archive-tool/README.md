# log-archive.sh

A simple Bash script that creates a compressed archive of a specified directory and saves it to a defined destination.

## Usage
```bash
./log-archive /path/to/directory
```

## Example
```bash
./log-archive /var/log
```

## ⚠️ Note

Archiving `/var/log` requires root privileges, as most log files are only readable by root:
```bash
sudo ./log-archive /var/log
```

## How it works

The script accepts a source directory as an argument and creates a `.tgz` archive in `/media/archive-logs/`, with the filename containing a timestamp (`logs_archive_YYYYMMDD_HHMMSS.tgz`).

Before archiving, it checks that:
- A source directory has been specified
- The source directory exists
- The destination directory exists

## Requirements

- Bash
- Linux
