#!/bin/sh

hugo

cp -Rf public/* ../alphapenng.github.io/docs/

cd ../alphapenng.github.io/

git config user.name “alphapenng”
git config user.email “barca8best@gmail.com

git add --ignore-removal . && git commit -m 'fix the size of pictures in "版本管理与Git入门"' && git push -u origin main

cd ../balabala/
