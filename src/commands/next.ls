require! {
  ramda: R
  \../modules/tasks : load
  \../modules/relative-time
}

module.exports = (args, _, log, path) ->
  load path .tasks
  |> R.group-by (.status)
  |> (-> it.doing or it.new)
  |> R.when (-> it), ([task]) ->
    log.info "#{task.name} (#{relative-time task.modified})"
