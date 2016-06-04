require! <[moment]>
require! <[
  ../classes/command-common.ls
  ../classes/log.ls
  ../functions/database.ls
]>
pause = {log, database} |> require \../functions/pause.ls

module.exports = class command-pause extends command-common
  command: "pause <ids...>"
  description: "Pause task."
  alias: \p
  action: (ids)->
    <- database.migrate
    ids |> each pause

