require! {
  ramda: R
  \../classes/command.ls : Common
  \../modules/log.ls
  \../modules/tasks.ls : load
  \../classes/tasks.ls : Tasks
}

module.exports = class RemoveAll extends Common
  command: "remove-all"
  description: "Remove todo-file at home directory."
  action: (a, b, path) ->>
    tasks-file = load path .path
    await Tasks.remove tasks-file
    log.output "Removed all tasks."
