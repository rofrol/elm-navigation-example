#!/usr/bin/env node

var fs = require('fs-extra');
var path = require('path');
var root = path.normalize(__dirname + '/..');
require('dotenv').config({path: root + '/.env'})
var dist = path.normalize(root + '/' + process.env.dist);
console.log(dist);

var env = {};

// browsersync acts as proxy, so there can't be requests with host and port different:
// No 'Access-Control-Allow-Origin' header is present on the requested resource
// http://stackoverflow.com/questions/36912610/enable-cors-in-gulp-browsersync/41176541#41176541
env.api_url = process.env.host;
if(process.env.port != "")
  env.api_url += ":" + process.env.port;
env.api_url += process.env.api_base


env.json_extension = process.env.json_extension;

var file = path.normalize(dist + '/js/env.js');
var str = 'var env = ' + JSON.stringify(env);
fs.mkdirpSync(dist + '/js');
fs.writeFile(file, str, function(err) {
    if(err) {
        return console.log(err);
    }

    var filename = path.basename(__filename);
    console.log('\n' + filename + ':');
    console.log('  env obj was saved to file ' + file + ':');
    console.log('  ' + str + '\n');
});
