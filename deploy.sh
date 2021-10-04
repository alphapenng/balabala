#!/bin/sh

hugo

cp -Rf public/* ../alphapenng.github.io/docs/

cd ../alphapenng.github.io/

git config user.name “alphapenng”
git config user.email “barca8best@gmail.com

git add --ignore-removal . && git commit -m 'add new post 「华为路由交换设备命令手册」' && git push -u origin main

cd ../balabala/
