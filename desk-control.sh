#!/bin/bash
currentstatus=$(idasen-control --status 2>&1)

# OK status
# ❯ idasen-control --status
# height: 54.57 (standing)
# time sitting: 0ms

# NOK status
# ❯ idasen-control --status
# Desk is not ready

echo "Current desk status: $currentstatus"

if [[ $currentstatus =~ 'Desk is not ready' ]]; then
    echo 'Desk is not ready. Trying to find current `idasen-control` process to kill it...'
    currentprocess=`ps aux | grep idasen-control | grep -v 'grep' | awk '{print $2}'`

    if [[ $currentprocess == '' ]]; then
        echo "Didn't find any 'idasen-control' process. Exiting!"
        exit 1
    fi

    echo "Found 'idasen-control' process: '$currentprocess'. Killing it..."
    kill $currentprocess
fi

echo "Will eventually run: idasen-control $1 $2"

# give it some time to gracefully die and recover
currentstatus=`idasen-control --status`
while [[ $currentstatus =~ 'Desk is not ready' ]]; do
    echo -n '.'
    sleep 1
    currentstatus=`idasen-control --status`
done

idasen-control $1 $2
