require! <[
  ../classes/command-common.ls
  ../classes/database.ls
  ../functions/add.ls
]>

module.exports = class command-add extends command-common
  command: "add <names...>"
  description: "Add task."
  alias: \a
  options:
    * ["-s, --start", "With start."]
    ...
  action: (names, {start}:options)->
    <- database.migrate
    names
    |> map (name)-> {name, start}
    |> each add

