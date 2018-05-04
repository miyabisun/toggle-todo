require! {
  \../modules/tasks.ls : load
  \../functions/to-int.ls
}

module.exports = ({ids}:args, _, log, path) ->
  tasks = load path
  ids.map to-int .for-each (id) ->
    task = tasks.find id
    switch
    | not task =>
      log.info "[Error] not found task (id = #{id})"
    | task.status is \doing =>
      log.info "[Error] #{task.id}: #{task.name} (already doing)"
    | task.status is \done =>
      task.update status: \doing
      log.info "[Start] #{task.id}: #{task.name} (done -> doing)"
    | _ =>
      task.update status: \doing
      log.info "[Start] #{task.id}: #{task.name}"
  tasks.save!
