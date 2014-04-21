XPTemplate priority=personal

XPT for
XSET len=10
for (var i=0; i<`len^; i++) {
  `cursor^
}

XPT forlen
XSET len=10
for (var i=0, len=`len^; i<len; i++) {
  `cursor^
}

XPT c
console.log(`cursor^);

XPT st
setTimeout(function() {
  `cursor^
}, `time^);

XPT si
setInterval(function() {
  `cursor^
}, `time^);

XPT r
var `name^ = require('`cursor^');

XPT m
module.exports = `cursor^;

XPT qu
document.querySelector(`cursor^);
