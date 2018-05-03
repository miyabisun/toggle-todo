require! {
  \../modules/log.ls
  \../modules/tasks.ls : load
  \../functions/list.ls
}

module.exports = (a, b, path) ->
  (tasks = load path)
    ..refresh!
    ..asced |> list log, _
    ..save!
