require! <[moment]>

module.exports = ({log, database}, id)-->
  err, target <- database.db.get """
    SELECT *
    FROM todo
    WHERE id = $id
  """, {$id: id}
  unless target => log.output "[Remove] #id: not found task."; return
  err, id <- database.db.run """
    DELETE FROM todo
    WHERE id = $id
  """, {$id: id}
  log.output "[Remove] #{target.id}: #{target.name} (#{target.modified |> moment.unix >> (.from-now!)})"

