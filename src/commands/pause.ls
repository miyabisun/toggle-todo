require! {
  \../functions/short-list.ls
  \../modules/tasks.ls : load
  \../functions/to-int.ls
}

module.exports = ({ids}:args, {all}:options, log, path) ->
  tasks = load path
  switch
  | all =>
    tasks.tasks
      .filter (.status is \doing)
      .for-each (task) ->
        log.info "[Pause] #{task.id}: #{task.name}  (#{task.status} -> new)"
        task.update status: \new
  | _ =>
    ids.map to-int .for-each (id) ->
      task = tasks.find id
      switch
      | not task =>
        log.info "[Error] not found task (id = #{id})"
      | task.status is \new =>
        log.info "[Error] #{task.id}: #{task.name} (already #{task.status})"
      | _ =>
        log.info "[Pause] #{task.id}: #{task.name} (#{task.status} -> new)"
        task.update status: \new
  tasks.save!
