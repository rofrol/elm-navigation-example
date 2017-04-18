#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/..

./tools/clean.sh && \
yarn && \
./tools/generate-env.js && \
cp -r src/images dist/ && \
cp -r src/styles dist/ && \
cp -r node_modules/normalize.css/normalize.css dist/styles && \
cp src/index.html dist
