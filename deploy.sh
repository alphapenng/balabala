#!/bin/sh

hugo

cp -rf public/* ../alphapenng.github.io/docs/

cd ../alphapenng.github.io/

git add * && git commit -m 'new article' && git push

cd ../balabala/
