require! {
  \../modules/log.ls
  \../modules/tasks.ls : load
}

module.exports = ([id, name], _, path) ->
  tasks = load path
  task = tasks.find id
  switch
  | not task =>
    log.output "[Error] not found task (id = #{id})"
  | name is task.name =>
    log.output "[Rename] #{id}: #{name} (already #{JSON.stringify name})"
  | _ =>
    log.output "[Rename] #{id}: #{name} (old: #{JSON.stringify task.name})"
    task.update {name}
    tasks.save!
