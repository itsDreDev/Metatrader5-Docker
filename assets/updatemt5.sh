#!/bin/bash

# Variables
CHECKSUM_FILE_URL="https://raw.githubusercontent.com/itsDreDev/Metatrader5-Docker/main/Metatrader/checksum.txt"
TERMINAL64_URL="https://github.com/itsDreDev/Metatrader5-Docker/raw/main/Metatrader/terminal64.exe"
LOCAL_FILE="/root/Metatrader/terminal64.exe"

# Download the checksum file from GitHub
wget -O /tmp/github_checksum.txt "${CHECKSUM_FILE_URL}"

if [ ! -f "/tmp/github_checksum.txt" ]; then
    echo "Failed to download the checksum file from GitHub."
    exit 1
fi

# Extract the checksum from the downloaded file
GITHUB_CHECKSUM=$(cat /tmp/github_checksum.txt | awk '{print $1}')

# Calculate the checksum of the local file
if [ -f "${LOCAL_FILE}" ]; then
    LOCAL_CHECKSUM=$(sha256sum "${LOCAL_FILE}" | awk '{print $1}')
else
    echo "Local file ${LOCAL_FILE} not found. Downloading a new copy."
    LOCAL_CHECKSUM=""
fi

# Compare the checksums
if [ "${GITHUB_CHECKSUM}" != "${LOCAL_CHECKSUM}" ]; then
    echo "Checksums do not match. Downloading the updated version from GitHub..."
    wget -O "${LOCAL_FILE}" "${TERMINAL64_URL}"
    
    if [ $? -eq 0 ]; then
        echo "Download and update of terminal64.exe completed successfully."
    else
        echo "Failed to download terminal64.exe from GitHub."
    fi
else
    echo "Checksums match. No update is necessary."
fi

# Clean up
rm /tmp/github_checksum.txt
