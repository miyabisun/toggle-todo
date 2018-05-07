// Generated by LiveScript 1.5.0
var load;
load = require('../modules/tasks');
module.exports = function(args, options, log, path){
  var names, start, end, tasks, status;
  names = args.names;
  start = options.start, end = options.end;
  tasks = load(path);
  status = (function(){
    switch (false) {
    case !end:
      return 'done';
    case !start:
      return 'doing';
    default:
      return 'new';
    }
  }());
  names.forEach(function(name){
    var id;
    id = tasks.add({
      name: name,
      status: status
    }).id;
    return log.info("[Add] " + id + ": " + name + " (" + status + ")");
  });
  return tasks.save();
};