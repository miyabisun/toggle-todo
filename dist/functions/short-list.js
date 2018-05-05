// Generated by LiveScript 1.5.0
var R, relativeTime;
R = require('ramda');
relativeTime = require('../modules/relative-time');
module.exports = function(log, tasks){
  var list, this$ = this;
  list = R.groupBy(function(it){
    return it.status;
  })(
  tasks);
  return [['done', 'done'], ['new', 'todo'], ['doing', 'doing']].forEach(function(arg$){
    var type, prefix, ref$;
    type = arg$[0], prefix = arg$[1];
    return (ref$ = list[type]) != null ? ref$.forEach(function(arg$){
      var id, name, modified;
      id = arg$.id, name = arg$.name, modified = arg$.modified;
      return log.info("[" + prefix + "] " + id + ": " + name + " (" + relativeTime(modified) + ")");
    }) : void 8;
  });
};