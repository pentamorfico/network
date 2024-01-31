#!/bin/bash

# Set the path to your repository

while true; do
    # Find and add 50,000 untracked files from the repository and all its subdirectories
    FILES=$(find . -type f -not -path "./.git/*" | head -n 50000)

    if [ -z "$FILES" ]; then
        echo "No more files to add."
        break
    fi

    echo "$FILES" | xargs git add
    git commit -m "Add batch of files"
    git push origin main  # Replace 'main' with your branch name

    echo "Batch committed and pushed."
done
