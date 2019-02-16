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
there's an error, the server will return ``{"error":true}``.
## License
MIT License

Copyright (C) 2019 Benjamin Lowry

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE. 
