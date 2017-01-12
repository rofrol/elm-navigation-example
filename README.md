## elm navigation example

I've created this example to have easy reference code how to use elm-lang/navigation without using hashes.

This example is based on:

- general structure taken from https://github.com/elm-lang/navigation/tree/master/examples
- the routing part from https://github.com/ohanhi/elm-taco

## How to try

To set up on your own computer, you will need `git`, `elm-0.18`, `node.js`, `yarnpkg`.

Also web browser with support of [Object.assign](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Object/assign) for loading `env.js`. There is also [polyfill](https://github.com/sindresorhus/object-assign).

Simply clone the repository and:


```bash
$ git clone https://github.com/rofrol/elm-navigation-example.git
$ cd elm-navigation-example
$ yarn
$ cp .env.example .env
$ ./tools/build-dev.sh
$ ./tools/server.js
```

In another terminal run:

```bash
$ ./tools/browsersync.js
```

Then navigate your browser to [http://localhost:8000](http://localhost:8000).

## Configuration

Based on https://12factor.net/config

```bash
cp .env.example .env
./tools/generate-env.js
```

You will get `dist/js/env.js` which is loaded to elm through flags.

## Linter elm make - don't compile twice

[There is a bug for that](https://github.com/mybuddymichael/linter-elm-make/issues/107).

In a file `~/.atom/packages/linter-elm-make/lib/linter-elm-make.js` change line

`let args = [inputFilePath, '--report=json', '--output=/dev/null', --yes'];`

to

`let args = [inputFilePath, '--report=json', '--output=dist/js/elm.js', '--debug', '--yes'];`

Restart atom.

You also need to setup main paths as is in `linter-elm-make.json` or run command as described in [Linter Elm Make: Set Main Paths](https://github.com/mybuddymichael/linter-elm-make#linter-elm-make-set-main-paths).

Also for me on Windows, linter-elm-make [couldn't use elm-make when elm installed from npm](https://github.com/mybuddymichael/linter-elm-make/issues/100). I had to install elm from executable.

## TODO

- [ ] use query string
- [ ] use ohanhi/elm-web-data
