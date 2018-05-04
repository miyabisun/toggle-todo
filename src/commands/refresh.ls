require! {
  \../modules/tasks : load
  \../functions/list
}

module.exports = (args, options, log, path) ->
  (tasks = load path)
    ..refresh!
    ..asced |> list log, _
    ..save!
