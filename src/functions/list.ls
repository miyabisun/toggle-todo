require! <[moment]>
require! <[
  ../classes/database.ls
]>

module.exports = ->
  err, rows <- database.db.all """
    SELECT *
    FROM todo
    ORDER BY is_ended DESC, is_started ASC, modified ASC
  """
  output = ({id, name, modified}:row)->
    "  #id: #name (#{modified |> moment.unix >> (.from-now!)})"
    |> console~log
  rows
  |> filter (.is_ended) >> (is 1)
  |> ->
    console.log "Ended tasks." if it.length
    return it
  |> each output
  rows
  |> filter (.is_ended) >> (is 0)
  |> filter (.is_started) >> (is 0)
  |> ->
    console.log "ToDo." if it.length
    return it
  |> each output
  rows
  |> filter (.is_ended) >> (is 0)
  |> filter (.is_started) >> (is 1)
  |> ->
    console.log "Started tasks." if it.length
    return it
  |> each output

