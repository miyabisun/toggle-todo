require! {
  ramda: R
  \../classes/command.ls : Common
  \../modules/tasks.ls : load
  \../modules/log.ls
  \../modules/relative-time.ls
}

module.exports = class List extends Common
  version: \1.0.0
  command: "next"
  description: "Output task."
  action: (a, b, path) ->
    load path .tasks
    |> R.group-by (.status)
    |> (-> it.doing or it.new)
    |> R.when (-> it), ([task]) ->
      log.output "#{task.name} (#{relative-time task.modified})"
