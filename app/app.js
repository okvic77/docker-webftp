var express = require('express')
var serveIndex = require('serve-index')

var app = express()

// Serve URLs like /ftp/thing as public/ftp/thing
app.use('/', express.static('/home'), serveIndex('/home', {'icons': true}));
app.listen(80)
