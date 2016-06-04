require! <[
  ../classes/command-common.ls
  ../classes/log.ls
  ../functions/database.ls
]>
rename = {log, database} |> require \../functions/rename.ls

module.exports = class command-rename extends command-common
  command: "rename <id> <name>"
  description: "Rename task."
  alias: \mv
  action: (id, name)->
    <- database.migrate
    rename id, name
