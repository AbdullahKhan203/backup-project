#!/bin/bash

echo "Starting backup + git automation..."

# 1. Create backup folder
mkdir -p backups

# 2. Timestamp
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# 3. Backup number system
count_file="backups/count.txt"

if [ ! -f "$count_file" ]
then
    echo 1 > "$count_file"
fi

count=$(cat "$count_file")

# 4. Create backup
tar -czf backups/backup_${count}_${timestamp}.tar.gz data

# 5. Check backup success
if [ $? -eq 0 ]
then
    echo "$(date): Backup #$count successful - backup_${count}_${timestamp}.tar.gz" >> backup.log

    # increment counter
    next_count=$((count + 1))
    echo $next_count > "$count_file"

    # =========================
    # 🔥 GIT AUTO SYNC FIXED
    # =========================

    # Add ONLY important files (ignore rule safe)
    git add data backup.sh backups/count.txt

    # Commit with auto number
    git commit -m "Backup #$count completed at $timestamp"

    # Push to GitHub
    git push origin main

else
    echo "$(date): Backup #$count failed" >> backup.log
    exit 1
fi
























