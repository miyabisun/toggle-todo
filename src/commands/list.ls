require! <[
  ../classes/command-common.ls
  ../classes/log.ls
  ../functions/database.ls
]>
list = {log, database} |> require \../functions/list.ls
short-list = {log, database} |> require \../functions/short-list.ls

module.exports = class command-list extends command-common
  version: \1.0.0
  command: "list"
  description: "Output task list."
  alias: \ls
  options:
    * ["-s, --short", "Show short list."]
    ...
  action: ({short}:options)->
    <- database.migrate
    switch
    | short => short-list!
    | _ => list!

