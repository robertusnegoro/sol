#!/bin/bash

# Configuration
POSTS_DIR="_posts"
CATEGORY_DIR="category"

# Ensure category directory exists
mkdir -p "$CATEGORY_DIR"

echo "Scanning $POSTS_DIR for categories..."

# Extract unique categories
# 1. grep: finds lines starting with 'category:' or 'categories:'
# 2. sed: removes the keys to leave values
# 3. tr: removes brackets [] and replaces commas with newlines (to split arrays)
# 4. sed: trims whitespace
# 5. sort | uniq: gets unique list
categories=$(grep -hE "^(categories|category):" "$POSTS_DIR"/*.md | \
             sed -E 's/^(categories|category): *//g' | \
             tr -d '[]"' | \
             tr ',' '\n' | \
             sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | \
             sort | uniq)

# Loop through categories and generate pages
echo "$categories" | while read -r category; do
    if [ -n "$category" ]; then
        # Create slug (lowercase, hyphen replaces space)
        slug=$(echo "$category" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
        
        target_dir="$CATEGORY_DIR/$slug"
        target_file="$target_dir/index.md"
        
        mkdir -p "$target_dir"
        
        # Write the file content
        cat > "$target_file" <<EOF
---
layout: archive
title: $category
type: category
permalink: /category/$slug/
---
EOF
        echo "Created: $target_file"
    fi
done

echo "Category generation complete."
