#!/bin/bash

# This script copies all the content from the root of the repository
# into the book/src directory, preparing it for mdBook.

# List of all directories to be copied
directories=(
    "file-upload"
    "oauth"
    "sql-injection"
    "xss"
)

# Copy each directory into the book/src folder
for dir in "${directories[@]}"; do
    if [ -d "$dir" ]; then
        echo "Copying '$dir' to 'book/src/$dir'"
        mkdir -p "book/src/$dir"
        # Use rsync to exclude .bak files
        rsync -av --exclude='*.bak' "$dir/" "book/src/$dir/"
    else
        echo "Directory $dir does not exist, skipping."
    fi
done

# Copy the main README.md as the introduction
if [ -f "README.md" ]; then
    echo "Copying 'README.md' to 'book/src/introduction.md'"
    cp "README.md" "book/src/introduction.md"
fi

# Fix typos and renamed directories in the copied markdown files
echo "Fixing typos and directory references in markdown files..."
find "book/src" -type f -name "*.md" -print0 | while IFS= read -r -d $'\0' file; do
    # Fix typos
    sed -i '' 's|slqi-examining-database|sqli-examining-database|g' "$file"
    sed -i '' 's|blind-time-delays-info-retrivial|blind-time-delays-info-retrieval|g' "$file"
    
    # Fix renamed directory references in file-upload
    sed -i '' 's|RCE-webshell-upload/|rce-webshell-upload/|g' "$file"
    sed -i '' 's|contenttype-restrictions-bypass/|content-type-restrictions-bypass/|g' "$file"
    sed -i '' 's|polygot-webshell/|polyglot-webshell/|g' "$file"
    
    # Fix renamed directory references in oauth
    sed -i '' 's|OAuth-hijacking/|oauth-hijacking/|g' "$file"
    sed -i '' 's|OAuth-implicit-flow/|oauth-implicit-flow/|g' "$file"
    sed -i '' 's|OAuth-profile-linking/|oauth-profile-linking/|g' "$file"
    sed -i '' 's|OAuth-stealing-proxy/|oauth-stealing-proxy/|g' "$file"
    sed -i '' 's|OAuth-stealing-redirect/|oauth-stealing-redirect/|g' "$file"
    
    # Fix SQL Injection image paths - no changes needed as images are now in same folder
    # Images are now children of index folders (basic-attacks/, union-attacks/, etc.)
done

echo "Content synchronization complete!"
