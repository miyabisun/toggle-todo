require! {
  \../modules/tasks : load
  \../functions/list
  \../functions/short-list
}

module.exports = (args, {long}:options, log, path) ->
  tasks = load path
  switch
  | long => list log, tasks.asced
  | _ => short-list log, tasks.asced
