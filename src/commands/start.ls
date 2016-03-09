require! <[
  ../classes/command-common.ls
  ../classes/database.ls
  ../functions/start.ls
]>

module.exports = class command-start extends command-common
  command: "start <ids...>"
  description: "Start task."
  alias: \s
  action: (ids)->
    <- database.migrate
    ids |> each start

