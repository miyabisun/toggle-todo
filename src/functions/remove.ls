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
  unless target => console.log "[Remove] #id: not found task."; return
  err, id <- database.db.run """
    DELETE FROM todo
    WHERE id = $id
  """, {$id: id}
  console.log "[Remove] #{target.id}: #{target.name} (#{target.modified |> moment.unix >> (.from-now!)})"

