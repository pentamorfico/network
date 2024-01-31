#!/bin/bash


BATCH_SIZE=100  # Number of files to process in each batch
COUNT=0
BATCH=()

while IFS= read -r -d $'\0' FILE; do
    BATCH+=("$FILE")
    let COUNT+=1
    echo $BATCH
    if [[ $COUNT -eq $BATCH_SIZE ]]; then
        git add "${BATCH[@]}"
        git commit -m "Add batch of files"
        git push origin main  # Replace 'main' with your branch name
        echo "Batch committed and pushed."
        
        # Reset for next batch
        COUNT=0
        BATCH=()
    fi
done < <(find . -type f -not -path "./.git/*" -print0)

# Process any remaining files
if [[ $COUNT -ne 0 ]]; then
    git add "${BATCH[@]}"
    git commit -m "Add batch of files"
    git push origin main  # Replace 'main' with your branch name
    echo "Final batch committed and pushed."
fi
