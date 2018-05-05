require! {
  \../functions/short-list
  \../modules/tasks : load
  \../functions/to-int
}

module.exports = ({ids}:args, {all}:options, log, path) ->
  tasks = load path
  switch
  | all =>
    tasks.tasks
      .filter (.status is \doing)
      .for-each (task) ->
        log.info "[Pause] #{task.id}: #{task.name}  (#{task.status} -> new)"
        task.pause!
  | _ =>
    ids.map to-int .for-each (id) ->
      task = tasks.find id
      switch
      | not task =>
        log.info "[Error] not found task (id = #{id})"
      | _ =>
        log.info "[Pause] #{task.id}: #{task.name} (#{task.status} -> new)"
        task.pause!
  tasks.save!
