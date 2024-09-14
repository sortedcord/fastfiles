#!/bin/bash

# Needs inotify-tools to work

# Directory to watch
WATCH_DIR="/home/aditya/fastfiles/docs/uploads/mait/notes"

# Check if the directory exists
if [ ! -d "$WATCH_DIR" ]; then
    echo "Directory $WATCH_DIR does not exist."
    exit 1
fi

# Use inotifywait to monitor the directory
inotifywait -m -e create --format "%f" "$WATCH_DIR" | while read NEW_FILE
do
    # Check if the new file has a .xopp extension
    if [[ "$NEW_FILE" == *.xopp ]]; then
        BASE_NAME="${NEW_FILE%.xopp}"
        PDF_FILE="$WATCH_DIR/$BASE_NAME.pdf"
        XOPP_FILE="$WATCH_DIR/$NEW_FILE"

        # Check if the corresponding PDF file exists
        # Run xournalpp with the new .xopp file and the corresponding .pdf file
        xournalpp -p "$PDF_FILE" "$XOPP_FILE"
        
        # Delete the .xopp file
        rm "$XOPP_FILE"

    fi
done
