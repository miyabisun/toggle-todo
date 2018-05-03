require! {
  ramda: R
  luxon: {DateTime}
  \../modules/relative-time.ls
}

module.exports = (log, tasks) ->
  list = tasks |> R.group-by (.status)
  [
    * \done, "Ended tasks."
    * \new, "ToDo."
    * \doing, "Started tasks."
  ].for-each ([type, title]) ->
    if list.(type)
      log.output title
      list.(type)?.for-each ({id, name, modified}) ->
        log.output "  #id: #name (#{relative-time modified})"
