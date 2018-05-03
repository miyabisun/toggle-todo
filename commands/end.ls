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
    | task.status is \done =>
      log.output "[Error] #{task.id}: #{task.name} (already #{task.status})"
    | _ =>
      task.update status: \done
      log.output "[End] #{task.id}: #{task.name}"
  tasks.save!
