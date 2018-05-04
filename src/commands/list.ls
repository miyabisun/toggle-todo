require! {
  \../modules/tasks : load
  \../functions/list
  \../functions/short-list
}

module.exports = (args, {short}:options, log, path) ->
  tasks = load path
  switch
  | short => short-list log, tasks.asced
  | _ => list log, tasks.asced
