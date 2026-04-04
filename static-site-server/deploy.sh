#!/bin/bash

REMOTE_USER="user"
REMOTE_HOST="ipaddress"
REMOTE_PATH="$HOME/path"
LOCAL_PATH="$HOME/path"

# Build del sito
hugo -d "$LOCAL_PATH"

# Sync verso il server remoto
rsync -azuP "$LOCAL_PATH" --delete "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"

# Fix dei permessi in remoto
ssh "$REMOTE_USER@$REMOTE_HOST" bash << EOF
    find $REMOTE_PATH -type d -exec chmod 755 {} \;
    find $REMOTE_PATH -type f -exec chmod 644 {} \;
EOF
