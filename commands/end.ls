require! {
  \../modules/tasks.ls : load
  \../functions/to-int.ls
}

module.exports = ({ids}:args, options, log, path) ->
  tasks = load path
  ids.map to-int .for-each (id) ->
    task = tasks.find id
    switch
    | not task =>
      log.info "[Error] not found task (id = #{id})"
    | task.status is \done =>
      log.info "[Error] #{task.id}: #{task.name} (already #{task.status})"
    | _ =>
      task.update status: \done
      log.info "[End] #{task.id}: #{task.name}"
  tasks.save!
