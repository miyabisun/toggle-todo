require! {
  ramda: R
  \../modules/tasks : load
  \../functions/to-int
}

module.exports = (args, options, log, path) ->
  tasks = load path
  tasks.tasks
  |> R.group-by (.status)
  |> (-> it.doing or it.new)
  |> R.when (-> it), ([task]) ->
    log.info "#{task.name} is done"
    task.done!
  tasks.save!
