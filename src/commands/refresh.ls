require! {
  \../modules/tasks.ls : load
  \../functions/list.ls
}

module.exports = (args, options, log, path) ->
  (tasks = load path)
    ..refresh!
    ..asced |> list log, _
    ..save!
