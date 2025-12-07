#!/bin/bash

# List of all directories to be copied
directories=(
    "file-upload"
    "oauth"
    "sql-injection"
    "xss"
    "README.md"
    "portswigger-lab.png"
)

cd $(git rev-parse --show-toplevel)

for dir in "${directories[@]}"; do
    if [ -d "$dir" ]; then
        echo "Copying '$dir' to 'book/src/$dir'"
        mkdir -p "book/src/$dir"
        cp -r "$dir/"* "book/src/$dir/"
    elif [ -f "$dir" ]; then
        echo "Copying '$dir' to 'book/src/$dir'"
        cp "$dir" "book/src/$dir"
    else
        echo "Directory $dir does not exist, skipping."
    fi
done