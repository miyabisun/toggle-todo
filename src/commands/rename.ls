require! {
  \../modules/tasks : load
  \../functions/to-int
}

module.exports = ({id: sid, name}:args, _, log, path) ->
  tasks = load path
  id = sid |> to-int
  task = tasks.find id
  switch
  | not task =>
    log.info "[Error] not found task (id = #{id})"
  | name is task.name =>
    log.info "[Rename] #{id}: #{name} (already #{JSON.stringify name})"
  | _ =>
    log.info "[Rename] #{id}: #{name} (old: #{JSON.stringify task.name})"
    task.update {name}
    tasks.save!
