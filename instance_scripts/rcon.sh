#!/usr/bin/env bash
SERVER_PROPERTIES_PATH="${SERVER_PROPERTIES_PATH:-server.properties}"
if [ -z "$MCRCON_HOST" ]; then
    export MCRCON_HOST=localhost
fi
if [ -z "$MCRCON_PORT" ]; then
    if [ -r "$SERVER_PROPERTIES_PATH" ]; then
        export MCRCON_PORT=`grep -e '^rcon\.port=' "$SERVER_PROPERTIES_PATH" | cut -d '=' -f 2-`
    else
        echo "Warning: Couldn't read rcon.port from $SERVER_PROPERTIES_PATH" >&2
    fi
fi
if [ -z "$MCRCON_PASS" ]; then
    if [ -r "$SERVER_PROPERTIES_PATH" ]; then
        export MCRCON_PASS=`grep -e '^rcon\.password=' "$SERVER_PROPERTIES_PATH" | cut -d '=' -f 2-`
    else
        echo "Warning: Couldn't read rcon.password from $SERVER_PROPERTIES_PATH" >&2
    fi
fi

mcrcon "$@"

