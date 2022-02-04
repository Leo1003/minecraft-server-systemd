#!/usr/bin/env bash
./rcon.sh "say Starting Automatic Backup..." &&
./rcon.sh "save-off" &&
./rcon.sh "save-all"

BACKUP_FILE="world-backup-$(date +%Y%m%d-%H%M%S).tar.zst"

mkdir -p backups

tar -c -v -I "zstd -19 -T0" -f "backups/$BACKUP_FILE" world world_nether world_the_end
retval=$?

if [ $retval -eq 0 ]; then
    echo "Automatic Backup Completed!"
    ./rcon.sh "say Automatic Backup Completed!"
    
    find backups -type f -mtime +1 -delete
else
    echo "Automatic Backup Failed! Please check the detail logs!"
    echo "Exit code: $retval"
    ./rcon.sh "say Automatic Backup Failed! Please check the detail logs!"
fi

./rcon.sh "save-on"


