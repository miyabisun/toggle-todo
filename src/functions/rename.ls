require! <[moment]>
require! <[
  ../classes/database.ls
]>

module.exports = (id, name)->
  err, target <- database.db.get """
    SELECT *
    FROM todo
    WHERE id = $id
  """, {$id: id}
  unless target => console.log "[Rename] #id: not found task."; return
  err, id <- database.db.run """
    UPDATE todo
    SET name = $name, modified = $modified
    WHERE id = $id
  """, {$id: id, $name: name, $modified: moment!.format \X}
  console.log "[Rename] #{target.id}: #{name} (#{target.modified |> moment.unix >> (.from-now!)})"

