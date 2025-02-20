#!/usr/bin/env bash
./rcon.sh "say Starting Automatic Backup..." &&
./rcon.sh "save-off" &&
./rcon.sh "save-all"

BACKUP_PREFIX="configs-backup"
BACKUP_FILE="$BACKUP_PREFIX-$(date +%Y%m%d-%H%M%S).tar.zst"

mkdir -p backups

tar -c --zstd -f "backups/$BACKUP_FILE" *.yml *.properties *.json eula.txt
retval=$?

if [ $retval -eq 0 ]; then
    echo "Automatic Backup Completed!"
    ./rcon.sh "say Automatic Backup Completed!"
    
    find backups -type f -name "$BACKUP_PREFIX-\*" -mtime +1 -delete
else
    echo "Automatic Backup Failed! Please check the detail logs!"
    echo "Exit code: $retval"
    ./rcon.sh "say Automatic Backup Failed! Please check the detail logs!"
fi

./rcon.sh "save-on"

