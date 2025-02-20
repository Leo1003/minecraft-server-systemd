#!/usr/bin/bash

# The server process has already terminated
if [ -n "$EXIT_CODE" ]; then
    exit 0
fi

./rcon.sh "say SERVER SHUTTING DOWN. Saving map..."
./rcon.sh "save-all"
./rcon.sh "stop"
retval=$?

if [ $retval -ne 0 ]; then
    exit 1
fi

# The ExecStop script should wait for the main process to stop
echo 'Waiting for main process stop...'
while ps -p $MAINPID > /dev/null; do
    sleep 1
done

exit 0

