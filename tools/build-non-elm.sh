#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/..

./tools/clean.sh && \
./tools/generate-env.js && \
cp -r src/images dist/ && \
cp -r src/styles dist/ && \
cp -r node_modules/normalize.css/normalize.css dist/styles && \
mkdir -p dist/styles/font-awesome
cp -r node_modules/font-awesome/css dist/styles/font-awesome/ && \
cp -r node_modules/font-awesome/fonts dist/styles/font-awesome/ && \
cp src/index.html dist
