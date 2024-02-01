#!/bin/bash

BATCH_SIZE=500  # Number of files to process in each batch
SKIP=0

while true; do
    # Find HTML files and select a specific batch
    find . -type f -name "*" -not -path "./.git/*" -print0 | tail -zn +$SKIP | head -zn $BATCH_SIZE | xargs -0 git add

    # Check if any files were added, if not, break the loop
    if [ $(git diff --cached --name-only | wc -l) -eq 0 ]; then
        echo "No more HTML files to add."
        break
    fi

    # Commit and push the batch
    git commit -m "Add batch of HTML files"
    git push origin main  # Replace 'main' with your branch name

    # Prepare for the next batch
    let SKIP+=BATCH_SIZE
    echo "Batch committed and pushed. Total files processed: $SKIP"

done
