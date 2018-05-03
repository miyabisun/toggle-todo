require! {
  ramda: R
  \../modules/log.ls
  \../modules/tasks.ls : load
  \../modules/relative-time.ls
}

module.exports = (args, _, path) ->
  load path .tasks
  |> R.group-by (.status)
  |> (-> it.doing or it.new)
  |> R.when (-> it), ([task]) ->
    log.output "#{task.name} (#{relative-time task.modified})"
