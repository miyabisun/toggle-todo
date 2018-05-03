require! {
  \../classes/command.ls : Common
  \../modules/log.ls : log
  \../modules/tasks.ls : load
}

module.exports = class Start extends Common
  command: "start <ids...>"
  description: "Start task."
  alias: \s
  action: (ids, _, path) ->
    tasks = load path
    ids.for-each (id) ->
      task = tasks.find id
      switch
      | not task =>
        log.output "[Error] not found task (id = #{id})"
      | task.status is \doing =>
        log.output "[Error] #{task.id}: #{task.name} (already doing)"
      | task.status is \done =>
        task.update status: \doing
        log.output "[Start] #{task.id}: #{task.name} (done -> doing)"
      | _ =>
        task.update status: \doing
        log.output "[Start] #{task.id}: #{task.name}"
    tasks.save!
