#!/bin/bash
# vim-based scratchpad for when you need to note something down as quickly as possible,
# and want to stop doing 'vi aoeu' or 'vi a' or 'vi blah' which takes a crap on your home directory.
# Assumes Dropbox installed.

mkdir -p ~/Dropbox/scratch/$(date +"%Y-%m-%d")
vim ~/Dropbox/scratch/$(date +"%Y-%m-%d")/$(date +"%Y-%m-%d-%H-%M-%S").txt

