#!/bin/sh

# Check if the X server is running
xset -q > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "X server check failed!"
    exit 1
fi

# Check if terminal64.exe is running under Wine
pgrep -af terminal64.exe > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "terminal64.exe check failed!"
    exit 1
fi

echo "Both checks passed!"
exit 0