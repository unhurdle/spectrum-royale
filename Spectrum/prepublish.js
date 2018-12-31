var http = require('https');
var fs = require('fs');

function download(filename, url) {
  var file = fs.createWriteStream(filename);
  var request = http.get(url, function(response) {
    response.pipe(file);
  });
}

console.log('Downloading playerglobal');
download('playerglobal.swc', 'https://fpdownload.macromedia.com/get/flashplayer/updaters/32/playerglobal32_0.swc');
