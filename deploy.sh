#!/usr/bin/env sh

# abort on errors
set -e

# build
npm run build

# navigate into the build output directory
cd dist

git init
git add -A
git commit -m 'deploy'

# create the main branch
git branch -M main

# if you are deploying to https://<USERNAME>.github.io/<REPO>
# git push -f git@github.com:o-drozzdyk/Design-Manager.git main:gh-pages
git push -f https://github.com/o-drozzdyk/Design-Manager.git main:gh-pages

cd -