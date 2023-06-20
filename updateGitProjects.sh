#!/bin/bash

# Define the root directory to search for subfolders
echo "Enter full path to folder:"
read full_path
root_dir=$full_path

# Find all subfolders in the root directory and loop through them
find "${root_dir}" -mindepth 1 -maxdepth 1 -type d | while read folder
do
    # Check if the folder is a Git repository
    if [ -d "${folder}/.git" ]; then
        # Change directory to the Git repository
        cd "${folder}"
        
        # Get the name of the current branch
        branch=$(git rev-parse --abbrev-ref HEAD)
        
        # Check if the current branch is master or main
        if [ "$branch" = "master" ] || [ "$branch" = "main" ]; then
            # Pull changes from the remote repository
            git pull
        else
            echo "Skipping ${folder}. It's not on the master/main branch."
        fi
    else
        echo "Skipping ${folder}. It's not a Git repository."
    fi
done
