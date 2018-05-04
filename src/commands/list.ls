require! {
  \../modules/tasks.ls : load
  \../functions/list.ls
  \../functions/short-list.ls
}

module.exports = (args, {short}:options, log, path) ->
  tasks = load path
  switch
  | short => short-list log, tasks.asced
  | _ => list log, tasks.asced
