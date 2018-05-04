// Generated by LiveScript 1.5.0
var fs, del, yaml, R, Task, Tasks, slice$ = [].slice;
fs = require('fs');
del = require('del');
yaml = require('js-yaml');
R = require('ramda');
Task = require('./task');
module.exports = Tasks = (function(){
  Tasks.displayName = 'Tasks';
  var prototype = Tasks.prototype, constructor = Tasks;
  function Tasks(path, tasks){
    this.path = path;
    this.tasks = tasks;
  }
  Tasks.from = function(path, tasks){
    tasks == null && (tasks = []);
    return new Tasks(path, tasks);
  };
  Tasks.save = function(path, tasks){
    tasks == null && (tasks = []);
    return fs.writeFileSync(path, yaml.safeDump(tasks));
  };
  Tasks.load = function(path){
    var seed, e;
    try {
      seed = yaml.safeLoad(fs.readFileSync(path));
      return Tasks.from(path, seed.map(Task.from));
    } catch (e$) {
      e = e$;
      Tasks.save(path);
      return Tasks.load(path);
    }
  };
  Tasks.remove = async function(path){
    return del(path);
  };
  Object.defineProperty(Tasks.prototype, 'newId', {
    get: function(){
      var this$ = this;
      return compose$(partialize$.apply(Math.max, [Math.max.apply, [null, void 8], [1]]), (function(it){
        return it || 0;
      }), (function(it){
        return it + 1;
      }))(
      this.tasks.map(function(it){
        return it.id || 0;
      }));
    },
    configurable: true,
    enumerable: true
  });
  Object.defineProperty(Tasks.prototype, 'asced', {
    get: function(){
      var this$ = this;
      return R.sortBy(function(it){
        return it.modified.valueOf();
      })(
      this.tasks);
    },
    configurable: true,
    enumerable: true
  });
  Object.defineProperty(Tasks.prototype, 'desced', {
    get: function(){
      var this$ = this;
      return R.reverse(
      R.sortBy(function(it){
        return it.modified.valueOf();
      })(
      this.tasks));
    },
    configurable: true,
    enumerable: true
  });
  Tasks.prototype.find = function(id){
    var this$ = this;
    return this.tasks.find(function(it){
      return it.id === id;
    });
  };
  Tasks.prototype.add = function(seed){
    var this$ = this;
    seed == null && (seed = {});
    return R.tap(function(it){
      return this$.tasks.push(it);
    })(
    Task.from(
    (function(it){
      return it.id = this$.newId, it;
    })(
    seed)));
  };
  Tasks.prototype.remove = function(id){
    var this$ = this;
    return this.tasks = R.reject(function(it){
      return it.id === id;
    })(
    this.tasks);
  };
  Tasks.prototype.refresh = function(){
    return this.tasks.forEach(function(task, i){
      return task.id = i + 1;
    });
  };
  Tasks.prototype.save = function(){
    var this$ = this;
    return Tasks.save(this.path, this.tasks.map(function(it){
      return it.task;
    }));
  };
  return Tasks;
}());
function compose$() {
  var functions = arguments;
  return function() {
    var i, result;
    result = functions[0].apply(this, arguments);
    for (i = 1; i < functions.length; ++i) {
      result = functions[i](result);
    }
    return result;
  };
}
function partialize$(f, args, where){
  var context = this;
  return function(){
    var params = slice$.call(arguments), i,
        len = params.length, wlen = where.length,
        ta = args ? args.concat() : [], tw = where ? where.concat() : [];
    for(i = 0; i < len; ++i) { ta[tw[0]] = params[i]; tw.shift(); }
    return len < wlen && len ?
      partialize$.apply(context, [f, ta, tw]) : f.apply(context, ta);
  };
}