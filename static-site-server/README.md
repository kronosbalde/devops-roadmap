# deploy.sh

A simple deployment script for static websites generated with Hugo.

## What it does

1. Builds the static site with `hugo`
2. Syncs the output to a remote web server via `rsync`
3. Fixes file and directory permissions on the remote server via `ssh`

## Usage

Edit the variables at the top of the script before running:
```bash
REMOTE_USER="your_user"
REMOTE_HOST="your_server_ip"
REMOTE_PATH="/path/on/remote"
LOCAL_PATH="$HOME/your/local/path"
```

Then run:
```bash
chmod +x deploy.sh
./deploy.sh
```

## Requirements

- `hugo` installed locally
- `rsync` and `ssh` available
- SSH key-based authentication configured on the remote server
