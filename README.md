# yt-info-server 
yt-info-server is a simple command-line HTTP server that lets clients get information about
YouTube videos, including title, thumbnail, related videos, direct links to
streamable video files, etc. using [ytdl-core](https://www.npmjs.com/package/ytdl-core).
## Installation
``$ npm install -g yt-info-server``
## Usage
To start hosting:

`$ yt-info-server port`

Replace `port` with the port to host on, e.g. 8080. If no port is specified,
the server will default to 5678.

Clients can get data from the server with a URL like this:

``http://localhost:5678/https://www.youtube.com/watch?v=q6EoRBvdVPQ``

Just append the full YouTube video URL to the server address to get info about
that video. The server will return the JSON output of ``ytdl.getInfo``. If
there's an error, the server will return a string describing the error, like this:

``{"error":"Error: Invalid video URL. The URL should be a full YouTube video URL."}``


## License
MIT License


