require! {
  \../modules/log.ls
  \../modules/tasks.ls : load
  \../classes/tasks.ls : Tasks
}

module.exports = (args, _, path) ->>
  tasks-file = load path .path
  await Tasks.remove tasks-file
  log.output "Removed all tasks."
