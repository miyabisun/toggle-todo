require! {
  ramda: R
  \../modules/log.ls
  \../functions/short-list.ls
  \../modules/tasks.ls : load
}

module.exports = (ids, {end, refresh}:options, path) ->
  tasks = load path
  s = deleted: no
  switch
  | end =>
    ended-tasks = tasks.tasks.filter (.status is \done)
    if not R.is-empty ended-tasks
      s.deleted = yes
      ended-tasks.for-each (task) ->
        tasks.remove task.id
        log.output "[Remove] #{task.id}: #{task.name}"
  | not R.is-empty ids =>
    ids.for-each (id) ->
      task = tasks.find id
      switch
      | not task =>
        log.output "[Error] not found task (id = #{id})"
      | _ =>
        s.deleted = yes
        tasks.remove task.id
        log.output "[Remove] #{task.id}: #{task.name}"
  if refresh and s.deleted
    log.output "----- ----- -----"
    log.output "Remaining tasks."
    tasks.refresh!
    short-list log, tasks.tasks
  tasks.save! if s.deleted
