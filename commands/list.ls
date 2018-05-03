require! {
  \../classes/command.ls : Common
  \../modules/tasks.ls : load
  \../modules/log.ls
  \../functions/list.ls
  \../functions/short-list.ls
}

module.exports = class List extends Common
  version: \1.0.0
  command: "list"
  description: "Output task list."
  alias: \ls
  options:
    * "-s, --short", "Show short list."
    ...
  action: ({short}:options, path) ->
    tasks = load path
    switch
    | short => short-list log, tasks.asced
    | _ => list log, tasks.asced
