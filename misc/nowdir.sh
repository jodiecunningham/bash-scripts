#!/usr/bin/env bash

# Ensure the script is starting in the home directory
cd ~

# Check if the function nowdir exists in ~/.bashrc
if ! grep -q "function nowdir" ~/.bashrc; then
  # Add alias to ~/.bashrc for the function nowdir
  echo "alias nowdir='bash ~/misc/nowdir.sh'" >> ~/.bashrc
  # Source ~/.bashrc
  source ~/.bashrc
fi

# Define the function nowdir
nowdir() {
  # Create a folder with today's date in ~/work/YYYYMMdd format
  folder=~/work/$(date +%Y%m%d)
  mkdir -p "$folder"
  # Change directory into the newly created folder
  cd "$folder"
}

# Call the function nowdir
nowdir

# Ensure the script is executable
chmod +x ~/misc/nowdir.sh
