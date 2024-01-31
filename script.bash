#!/bin/bash


BATCH_SIZE=100  # Number of files to process in each batch
COUNT=0

find . -type f -not -path "./.git/*" -print0 | while IFS= read -r -d $'\0' FILE; do
    git add "$FILE"
    let COUNT+=1

    if [[ $COUNT -eq $BATCH_SIZE ]]; then
        git commit -m "Add batch of files"
        git push origin main  # Replace 'main' with your branch name
        echo "Batch committed and pushed."
        
        # Reset count for the next batch
        COUNT=0
    fi
done

# Process any remaining files
if [[ $COUNT -ne 0 ]]; then
    git commit -m "Add batch of files"
    git push origin main  # Replace 'main' with your branch name
    echo "Final batch committed and pushed."
fi
