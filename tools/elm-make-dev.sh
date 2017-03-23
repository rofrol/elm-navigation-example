#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/..

./node_modules/.bin/elm-make src/elm/Main.elm --output=dist/js/elm.js --yes --debug
