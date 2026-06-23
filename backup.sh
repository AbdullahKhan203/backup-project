#!/bin/bash

echo "Starting backup + git automation..."

# 1. Create backup folder
mkdir -p backups

# 2. Timestamp
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# 3. Backup number (auto increment)
count_file="backups/count.txt"

if [ ! -f "$count_file" ]
then
    echo 1 > "$count_file"
fi

count=$(cat "$count_file")

# 4. Create backup
tar -czf backups/backup_${count}_${timestamp}.tar.gz data

# 5. Check result
if [ $? -eq 0 ]
then
    echo "$(date): Backup #$count successful - backup_${count}_${timestamp}.tar.gz" >> backup.log

    # increase counter
    count=$((count + 1))
    echo $count > "$count_file"
else
    echo "$(date): Backup #$count failed" >> backup.log
    exit 1
fi




















