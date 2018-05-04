require! {
  ramda: R
  \../modules/relative-time
}

module.exports = (log, tasks) ->
  list = tasks |> R.group-by (.status)
  [
    * \done, \Done
    * \new, \ToDo
    * \doing, \Doing
  ].for-each ([type, prefix]) ->
    list.(type)?.for-each ({id, name, modified}) ->
      log.info "[#prefix] #id: #name (#{relative-time modified})"
