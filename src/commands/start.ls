require! {
  \../modules/tasks : load
  \../functions/to-int
}

module.exports = ({ids}:args, _, log, path) ->
  tasks = load path
  ids.map to-int .for-each (id) ->
    task = tasks.find id
    switch
    | not task =>
      log.info "[Error] not found task (id = #{id})"
    | _ =>
      log.info "[Start] #{task.id}: #{task.name} (#{task.status} -> doing)"
      task.do!
  tasks.save!
