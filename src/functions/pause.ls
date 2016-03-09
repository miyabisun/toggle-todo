require! <[moment]>
require! <[
  ../classes/database.ls
]>

module.exports = (id)->
  err, target <- database.db.get """
    SELECT *
    FROM todo
    WHERE id = $id
  """, {$id: id}
  unless target => console.log "[Pause] #id: not found task."; return
  err, id <- database.db.run """
    UPDATE todo
    SET is_started = 0, modified = $modified
    WHERE id = $id
  """, {$id: id, $modified: moment!.format \X}
  console.log "[Pause]  #{target.id}: #{target.name} (#{target.modified |> moment.unix >> (.from-now!)})"

