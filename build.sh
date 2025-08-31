#!/bin/bash

echo "running build"

git status

# pull branch v4_personal
git remote set-branches origin 'v4_personal'
git fetch --depth 1 origin v4_personal
git checkout v4_personal

ls # hope this shows everything?

echo "---"
cat quartz.config.ts  # to validate it exists
echo "--- quartz.config.ts OVER"

echo "purging dummy content folder"
rm -rf content

echo "copy content folder from public_notes branch"
git checkout public_notes -- content

# list node and npm versions
node --version
npm --version

echo "install npm dependencies"
npm ci

echo "build quartz"
npx quartz build

# at this point, I hope the public folder will be available for deployment.
