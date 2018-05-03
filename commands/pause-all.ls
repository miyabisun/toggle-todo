require! <[
  ../classes/command-common.ls
  ../classes/log.ls
  ../functions/database.ls
]>
pause = {log, database} |> require \../functions/pause.ls

module.exports = class command-pause-all extends command-common
  command: "pause-all"
  description: "Pause all tasks."
  action: ->
    <- database.migrate
    err, targets <- database.db.all """
      SELECT *
      FROM todo
      WHERE is_started = 1
    """
    if empty targets => console.log "[PauseAll] not found task."; return
    targets |> each (.id) >> pause

