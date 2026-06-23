#!/bin/bash

SOURCE="./data"
DEST="./backups"
LOG="./backup.log"

mkdir -p "$DEST"

TIME=$(date +"%Y-%m-%d_%H-%M-%S")
FILE="$DEST/backup_$TIME.tar.gz"

tar -czf "$FILE" "$SOURCE"

if [ $? -eq 0 ]; then
    echo "$TIME Backup SUCCESS" >> "$LOG"
     echo "Backup run completed" >> "$LOG"
    echo "Backup done"
else
    echo "$TIME Backup FAILED" >> "$LOG"
fi
