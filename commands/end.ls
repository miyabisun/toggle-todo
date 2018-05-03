require! {
  \../classes/command.ls : Common
  \../modules/log.ls : log
  \../modules/tasks.ls : load
}

module.exports = class End extends Common
  command: "end <ids...>"
  description: "End task."
  alias: \e
  action: (ids, _, path) ->
    tasks = load path
    ids.for-each (id) ->
      task = tasks.find id
      switch
      | not task =>
        log.output "[Error] not found task (id = #{id})"
      | task.status is \done =>
        log.output "[Error] #{task.id}: #{task.name} (already done)"
      | _ =>
        task.update status: \done
        log.output "[End] #{task.id}: #{task.name}"
    tasks.save!
