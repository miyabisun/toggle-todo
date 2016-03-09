require! <[
  ../classes/command-common.ls
  ../classes/database.ls
  ../functions/list.ls
  ../functions/short-list.ls
]>

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

