require! <[
  ../classes/command-common.ls
  ../classes/log.ls
  ../functions/database.ls
]>
next = {log, database} |> require \../functions/next.ls

module.exports = class command-list extends command-common
  version: \1.0.0
  command: "next"
  description: "Output task."
  action: ->
    <- database.migrate
    next!

