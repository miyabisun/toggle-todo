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
  output = (prefix, {id, name, modified}:row)-->
    "[#prefix] #id: #name (#{modified |> moment.unix >> (.from-now!)})"
    |> console~log
  rows
  |> filter (.is_ended) >> (is 1)
  |> each output \Ended
  rows
  |> filter (.is_ended) >> (is 0)
  |> filter (.is_started) >> (is 0)
  |> each output \ToDo
  rows
  |> filter (.is_ended) >> (is 0)
  |> filter (.is_started) >> (is 1)
  |> each output \Started

