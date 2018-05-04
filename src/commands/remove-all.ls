require! {
  \../modules/tasks : load
  \../classes/tasks : Tasks
}

module.exports = (args, _, log, path) ->>
  tasks-file = load path .path
  await Tasks.remove tasks-file
  log.info "Removed all tasks."
