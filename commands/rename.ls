require! {
  \../classes/command.ls : Common
  \../modules/log.ls : log
  \../modules/tasks.ls : load
}

module.exports = class End extends Common
  command: "rename <id> <name>"
  description: "Rename task."
  alias: \mv
  action: (id, name, _, path) ->
    tasks = load path
    task = tasks.find id
    switch
    | not task =>
      log.output "[Error] not found task (id = #{id})"
    | name is task.name =>
      log.output "[Rename] #{id}: #{name} (already #{JSON.stringify name})"
    | _ =>
      log.output "[Rename] #{id}: #{name} (old: #{JSON.stringify task.name})"
      task.update {name}
      tasks.save!
