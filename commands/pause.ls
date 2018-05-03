require! {
  ramda: R
  \../modules/log.ls
  \../functions/short-list.ls
  \../modules/tasks.ls : load
}

module.exports = (ids, {all}:options, path) ->
  tasks = load path
  switch
  | all =>
    tasks.tasks
      .filter (.status is \doing)
      .for-each (task) ->
        log.output "[Pause] #{task.id}: #{task.name}  (#{task.status} -> new)"
        task.update status: \new
  | _ =>
    ids.for-each (id) ->
      task = tasks.find id
      switch
      | not task =>
        log.output "[Error] not found task (id = #{id})"
      | task.status is \new =>
        log.output "[Error] #{task.id}: #{task.name} (already #{task.status})"
      | _ =>
        log.output "[Pause] #{task.id}: #{task.name} (#{task.status} -> new)"
        task.update status: \new
  tasks.save!
