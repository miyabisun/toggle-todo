require! {
  \../modules/log.ls
  \../modules/tasks.ls : load
}

module.exports = (ids, _, path) ->
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
