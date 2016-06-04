require! <[moment]>

module.exports = ({log, database})-> ->
  err, rows <- database.db.all """
    SELECT *
    FROM todo
    ORDER BY is_ended DESC, is_started ASC, modified ASC
  """
  output = ({id, name, modified}:row)->
    "  #id: #name (#{modified |> moment.unix >> (.from-now!)})"
    |> log.output
  rows
  |> filter (.is_ended) >> (is 1)
  |> ->
    log.output "Ended tasks." if it.length
    return it
  |> each output
  rows
  |> filter (.is_ended) >> (is 0)
  |> filter (.is_started) >> (is 0)
  |> ->
    log.output "ToDo." if it.length
    return it
  |> each output
  rows
  |> filter (.is_ended) >> (is 0)
  |> filter (.is_started) >> (is 1)
  |> ->
    log.output "Started tasks." if it.length
    return it
  |> each output

