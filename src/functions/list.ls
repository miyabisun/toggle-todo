require! {
  ramda: R
  \../modules/relative-time
}

module.exports = (log, tasks) ->
  list = tasks |> R.group-by (.status)
  [
    * \done, "Done tasks."
    * \new, "ToDo."
    * \doing, "Doing tasks."
  ].for-each ([type, title]) ->
    if list.(type)
      log.info title
      list.(type)?.for-each ({id, name, modified}) ->
        log.info "  #id: #name (#{relative-time modified})"
