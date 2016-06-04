require! <[moment]>

module.exports = ({log, database})-> ->
  err, targets <- database.db.all """
    SELECT *
    FROM todo
  """
  if empty targets => log.output "not found task."; return
  targets
  |> zip [1 to targets.length]
  |> -> log.output "tasks of refreshed by id."; it
  |> each ([new-id, target])->
    err, id <- database.db.run """
      UPDATE todo
      SET id = $new_id
      WHERE id = $id
    """, {$new_id: new-id, $id: target.id}
    log.output "  #{new-id}: #{target.name} (#{target.modified |> moment.unix >> (.from-now!)})"
