require! <[moment]>
require! <[
  ../classes/database.ls
]>

module.exports = ->
  err, targets <- database.db.all """
    SELECT *
    FROM todo
  """
  if empty targets => console.log "not found task."; return
  targets
  |> zip [1 to targets.length]
  |> -> console.log "tasks of refreshed by id."; it
  |> each ([new-id, target])->
    err, id <- database.db.run """
      UPDATE todo
      SET id = $new_id
      WHERE id = $id
    """, {$new_id: new-id, $id: target.id}
    console.log "  #{new-id}: #{target.name} (#{target.modified |> moment.unix >> (.from-now!)})"
