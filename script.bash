#!/bin/bash


BATCH_SIZE=20000  # Number of files to process in each batch
SKIP=0

while true; do
    # Find files and select a specific batch
    find . -type f -not -path "./.git/*" -print0 | head -zn +$SKIP | tail -zn $BATCH_SIZE | xargs -0 git add

    # Commit and push the batch
    git commit -m "Add batch of files"
    git push origin main  # Replace 'main' with your branch name

    # Prepare for the next batch
    let SKIP+=BATCH_SIZE
    echo "Batch committed and pushed. Total files processed: $SKIP"

done
