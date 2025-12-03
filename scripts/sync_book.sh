#!/bin/bash

# This script copies all the content from the root of the repository
# into the book/src directory, preparing it for mdBook.

# Change to repository root directory
cd "$(git rev-parse --show-toplevel)" || exit 1

# List of all directories to be copied
directories=(
    "file-upload"
    "oauth"
    "sql-injection"
    "xss"
)

# Clean and recreate book/src directory structure
echo "Preparing book/src directory..."
mkdir -p book/src

# Remove old synced directories to avoid stale content
echo "Cleaning old synced directories..."
for dir in "${directories[@]}"; do
    if [ -d "book/src/$dir" ]; then
        rm -rf "book/src/$dir"
    fi
done

# Copy each directory into the book/src folder
for dir in "${directories[@]}"; do
    if [ -d "$dir" ]; then
        echo "Copying '$dir' to 'book/src/$dir'"
        mkdir -p "book/src/$dir"
        # Use rsync to exclude .bak files and copy contents
        rsync -av --exclude='*.bak' "$dir/" "book/src/$dir/"
    else
        echo "Directory $dir does not exist, skipping."
    fi
done

# Copy the main README.md as the introduction
if [ -f "README.md" ]; then
    echo "Copying 'README.md' to 'book/src/introduction.md'"
    cp "README.md" "book/src/introduction.md"
else
    echo "README.md not found!"
fi

echo "Content synchronization complete!"
