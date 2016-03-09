require! <[moment]>
require! <[
  ../classes/database.ls
]>

module.exports = (id)->
  err, target <- database.db.get """
    SELECT *
    FROM todo
    WHERE id = $id AND is_started = 1
  """, {$id: id}
  unless target => console.log "[End] #id: not found task."; return
  err, id <- database.db.run """
    UPDATE todo
    SET is_ended = 1, modified = $modified
    WHERE id = $id
  """, {$id: id, $modified: moment!.format \X}
  console.log "[End] #{target.id}: #{target.name} (#{target.modified |> moment.unix >> (.from-now!)})"

