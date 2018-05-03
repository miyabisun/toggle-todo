require! {
  \../classes/command.ls : Common
  \../modules/tasks.ls : load
  \../modules/log.ls
  \../functions/list.ls
}

module.exports = class Refresh extends Common
  command: "refresh"
  description: "Refresh all tasks id."
  action: (a, b, path) ->
    (tasks = load path)
      ..refresh!
      ..asced |> list log, _
      ..save!
