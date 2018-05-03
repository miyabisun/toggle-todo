require! {
  ramda: R
  \../functions/short-list.ls
  \../modules/tasks.ls : load
  \../functions/to-int
}

module.exports = ({ids}:args, {end, refresh}:options, log, path) ->
  tasks = load path
  s = deleted: no
  switch
  | end =>
    ended-tasks = tasks.tasks.filter (.status is \done)
    if not R.is-empty ended-tasks
      s.deleted = yes
      ended-tasks.for-each (task) ->
        tasks.remove task.id
        log.info "[Remove] #{task.id}: #{task.name}"
  | not R.is-empty ids =>
    ids.map to-int .for-each (id) ->
      task = tasks.find id
      switch
      | not task =>
        log.info "[Error] not found task (id = #{id})"
      | _ =>
        s.deleted = yes
        tasks.remove task.id
        log.info "[Remove] #{task.id}: #{task.name}"
  if refresh and s.deleted
    log.info "----- ----- -----"
    log.info "Remaining tasks."
    tasks.refresh!
    short-list log, tasks.tasks
  tasks.save! if s.deleted
