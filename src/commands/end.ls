require! <[
  ../classes/command-common.ls
  ../classes/log.ls
  ../functions/database.ls
]>
end = {log, database} |> require \../functions/end.ls

module.exports = class command-end extends command-common
  command: "end <ids...>"
  description: "End task."
  alias: \e
  action: (ids)->
    <- database.migrate
    ids |> each end