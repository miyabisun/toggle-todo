require! {
  ramda: R
  \../modules/relative-time
}

module.exports = (log, tasks) ->
  list = tasks |> R.group-by (.status)
  [
    * \done, \done
    * \new, \todo
    * \doing, \doing
  ].for-each ([type, prefix]) ->
    list.(type)?.for-each ({id, name, modified}) ->
      log.info "[#prefix] #id: #name (#{relative-time modified})"
