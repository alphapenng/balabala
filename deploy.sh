#!/bin/sh

hugo

cp -Rf public/* ../alphapenng.github.io/docs/

cd ../alphapenng.github.io/

git config user.name “alphapenng”
git config user.email “barca8best@gmail.com

git add --ignore-removal . && git commit -m 'add new post' && git push -u origin main

cd ../balabala/
