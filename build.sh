#!/bin/bash

echo "running build"

git status

# pull branch v4_personal
git remote set-branches origin 'v4_personal'
git fetch --depth 1 origin v4_personal
git checkout v4_personal

ls # hope this shows everything?

cat quartz.config.ts  # to validate it exists