var fs = require('fs-extra');
var path = require('path');

// html = fs.readFileSync('/Projects/Repository/Saltfactory/tistory-editor/spec/2017-07-08-create-tistory-markdown-editor.md.html');
// html = html.toString()
html = '<img src="./image/test.png" alt="alt" name="name"/><img src="./image/test/test1.png"/><img src="./test2.png"/>'


var rex = /<img [^>]*src="([^>"]+\/([^>"]+))"[^>]*?>/g

// var rex = /<img(.+)src=\"[^\"]+\"(.*)>/g
var matches = html.match(rex)
// console.log(matches)

html = html.replace(rex, '<img src="$1"/>')
console.log(html)
