require! {
  \../classes/command.ls : Common
  \../modules/tasks.ls : load
  \../modules/log.ls
  \../functions/list.ls
  \../functions/short-list.ls
}

module.exports = ({short}:options, path) ->
  tasks = load path
  switch
  | short => short-list log, tasks.asced
  | _ => list log, tasks.asced
