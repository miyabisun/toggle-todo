require! <[
  ../classes/command-common.ls
  ../classes/database.ls
  ../functions/rename.ls
]>

module.exports = class command-rename extends command-common
  command: "rename <id> <name>"
  description: "Rename task."
  alias: \mv
  action: (id, name)->
    <- database.migrate
    rename id, name
