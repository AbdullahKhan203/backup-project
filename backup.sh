#!/bin/bash

echo "Starting backup + git automation..."

# 1. Create backup folder
mkdir -p backups

# 2. Timestamp
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# 3. Create backup of current state
tar -czf backups/backup_$timestamp.tar.gz data

if [ $? -eq 0 ]
then
    echo "$(date): Backup successful - backup_$timestamp.tar.gz" >> backup.log
else
    echo "$(date): Backup failed" >> backup.log
    exit 1
fi

# 4. Git automation
git add .

# 5. Commit only if there are changes
if ! git diff --cached --quiet; then
    git commit -m "Auto backup + commit at $timestamp"
    git push origin main
    echo "$(date): Git commit & push successful" >> backup.log
else
    echo "$(date): No changes to commit" >> backup.log
fi

echo "Done."













