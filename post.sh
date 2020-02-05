#!/bin/sh

# Script to add new content to github
# version: 0.1

echo "git committing..."
echo ""
git add .
git commit -m "$1"
git push -u origin master
echo ""
echo "------ git status:------"
git status
