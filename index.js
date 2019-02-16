#!/usr/bin/env node
var http = require('http');
var ytdl = require('ytdl-core')

var serverPort = process.argv[2];
if (serverPort == undefined) {
    serverPort = 5678; // Set default port
}

function serverLog(text) {
    console.log("[" + new Date(Date.now()).toUTCString() + "] " + text);
}
serverLog("yt-info-server 1.0.0 by Benjamin Lowry. Licensed under the MIT license.");
serverLog("Starting server on port " + serverPort.toString()); // Startup text

process.on('SIGINT', () => { // Handle ^C
    console.log(""); // Blank line so that the ^C will be on a separate line from the Exiting text
    serverLog("Exiting...");
    process.exit();
});

http.createServer(async function(request, response) {
    var vidId = request.url.replace("/", "");
    if (!ytdl.validateURL(vidId)) { // URL is not valid
        serverLog("Serving error");
        response.writeHead(404, {'Content-Type': 'application/json'});
        response.write("{\"error\":true}");
        response.end()
    } else {
        var info;
        ytdl.getInfo(vidId).then((value) => { // Promise fulfilled
            serverLog("Serving info for " + vidId);
            response.writeHead(200, {'Content-Type': 'application/json'});
            response.write(JSON.stringify(value)); // Convert the object ytdl gives us into a JSON string we can return
            response.end();
        }, (reason) => { // Promise rejected
            serverLog("Serving error");
            response.writeHead(404, {'Content-Type': 'application/json'});
            response.write("{\"error\":true}");
            response.end()
        });
    }
}).listen(serverPort);