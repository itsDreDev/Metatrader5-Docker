#!/bin/bash

# Check if a file name was provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

# The file path is the first argument to the script
FILE_PATH="$1"

# Check if the file exists
if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File does not exist."
    exit 2
fi

# Calculate and print the SHA-256 checksum of the file
sha256sum "$FILE_PATH"
