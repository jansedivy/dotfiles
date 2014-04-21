XPTemplate priority=personal

XPT fclass
var Class = require('./class');

module.exports = function(app) {
  var `name^ = Class.extend({
    init: function() {
      `cursor^`
    }
  });

  return `name^;
};

XPT class
var Class = require('./class');

var `name^ = Class.extend({
  init: function() {
    `cursor^
  }
});

module.exports = `name^;

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

XPT f
XSET arg*|post=ExpandIfNotEmpty(', ', 'arg*')
var `name^ = function(`arg*^) {
  `cursor^
};

XPT r
var `name^ = require('`cursor^');

XPT ex
module.exports = `cursor^;

XPT qu
document.querySelector(`cursor^);
