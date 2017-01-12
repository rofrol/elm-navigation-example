#!/usr/bin/env node

var express = require('express');
var app = express();
var path = require('path');
var root = path.normalize(__dirname + '/..');
require('dotenv').config({path: root + '/.env'})

// http://stackoverflow.com/questions/26349497/node-express-with-static-html-how-to-route-all-requests-to-index-html/26638143#26638143
// or maybe use https://github.com/bripkens/connect-history-api-fallback

console.log('process.env.NODE_ENV:', process.env.NODE_ENV);

var dist = path.normalize(root + '/' + process.env.dist);

console.log(dist);

// http://stackoverflow.com/questions/7067966/how-to-allow-cors/7069902
// CORS middleware
var allowCrossDomain = function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "X-Requested-With");
  next();
}
app.use(allowCrossDomain);

app.use('/api', express.static(root + '/api'));
app.use('/js', express.static(dist + '/js/'));
app.use('/styles', express.static(dist + '/styles'));
app.use('/images', express.static(dist + '/images'));

app.get('/*', function(req, res){
  res.sendFile(dist + '/index.html');
});

var port = process.env.static_port;
var server = app.listen(port, function() {

  var host = server.address().address;
  if(host === "::") host = "localhost";
  var port = server.address().port;

  console.log('Server listening at http://%s:%s', host, port);
});
