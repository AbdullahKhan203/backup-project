#!/bin/bash

echo "Starting backup + git automation..."

# 1. Create backup folder
mkdir -p backups

# 2. Timestamp
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# =========================
# 🔥 GET BACKUP NUMBER FROM GIT HISTORY
# =========================

last_num=$(git log --oneline | grep "Backup #" | head -1 | grep -o "#[0-9]*" | grep -o "[0-9]*")

if [ -z "$last_num" ]
then
    count=1
else
    count=$((last_num + 1))
fi

# 3. Create backup
tar -czf backups/backup_${count}_${timestamp}.tar.gz data

# 4. Check result
if [ $? -eq 0 ]
then
    echo "$(date): Backup #$count successful - backup_${count}_${timestamp}.tar.gz" >> backup.log

    # =========================
    # 🔥 GIT AUTO COMMIT
    # =========================

    git add data backup.sh backup.log backups

    git commit -m "Backup #$count completed at $timestamp"

    git push origin main

else
    echo "$(date): Backup #$count failed" >> backup.log
    exit 1
fi























