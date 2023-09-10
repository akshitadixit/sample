#!/bin/sh

# Initialize variables with default values
add_path=""
commit_msg=""
remote_name=""
branch_name=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -m|--message)
            shift
            commit_msg="$1"
            shift
            ;;
        -u|--remote)
            shift
            remote_name="$1"
            shift
            ;;
        *)
            add_path="$1"
            shift
            ;;
    esac
done

# Function to add files or directories to the Git staging area
add_to_git() {
    if [ -n "$add_path" ]; then
        git add "$add_path"
    else
        git add .
    fi
}

# Add files/directories to the Git staging area
add_to_git

# Commit the changes with the provided message
git commit -m "$commit_msg"

# Push the changes if remote information is provided
if [ -n "$remote_name" ]; then
    git push -u "$remote_name" "$branch_name"
else
    git push
fi

