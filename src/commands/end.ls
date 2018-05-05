require! {
  \../modules/tasks : load
  \../functions/to-int
}

module.exports = ({ids}:args, options, log, path) ->
  tasks = load path
  ids.map to-int .for-each (id) ->
    task = tasks.find id
    switch
    | not task =>
      log.info "[Error] not found task (id = #{id})"
    | _ =>
      log.info "[End] #{task.id}: #{task.name} (#{task.status} -> done)"
      task.done!
  tasks.save!
