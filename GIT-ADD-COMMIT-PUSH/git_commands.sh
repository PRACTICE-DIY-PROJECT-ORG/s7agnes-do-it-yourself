#!/bin/bash

# Save command history to a file
history > command_history.txt

# Navigate to your repository (replace 'path/to/your/repo' with the actual path)
#cd path/to/your/repo

# Move the command history file to your repository directory
# mv path/to/command_history.txt .
cp -r "C:\DIY-project-with-Eric\AWS_TEMPLATES\command_history.txt" .

# Stage the file
git add command_history.txt

# Commit the changes
git commit -m "Add command history"

# Push to GitHub
git push origin main
