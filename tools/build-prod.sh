#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/..

./tools/build-non-elm.sh && \
./tools/elm-make-prod.sh
