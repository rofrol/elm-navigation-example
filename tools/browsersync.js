#!/usr/bin/env node

var root = __dirname + '/..';
require('dotenv').config({path: root + '/.env'})
var browserSync = require('browser-sync');

browserSync({
    proxy: 'localhost:' + process.env.static_port,
    serveStatic: [],
    files: [root + '/dist', root + '/api'],
    open: false,
    port: process.env.browsersync_port,
    reloadDebounce: 1000
});
