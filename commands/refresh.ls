require! <[
  ../classes/command-common.ls
  ../classes/log.ls
  ../functions/database.ls
]>
refresh = {log, database} |> require \../functions/refresh.ls
list = {log, database} |> require \../functions/list.ls

module.exports = class command-refresh extends command-common
  command: "refresh"
  description: "Refresh all tasks id."
  action: ->
    <- database.migrate
    refresh!
    list!

