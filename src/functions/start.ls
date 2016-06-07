require! <[moment]>

module.exports = ({log, database}, id)-->
  err, target <- database.db.get """
    SELECT *
    FROM todo
    WHERE id = $id
  """, {$id: id}
  unless target => log.output "[Start] #id: not found task."; return
  err, id <- database.db.run """
    UPDATE todo
    SET is_started = 1, is_ended = 0, modified = $modified
    WHERE id = $id
  """, {$id: id, $modified: moment!.format \X}
  log.output "[Start] #{target.id}: #{target.name} (#{target.modified |> moment.unix >> (.from-now!)})"

