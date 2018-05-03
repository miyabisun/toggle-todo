require! {
  \../classes/command-common.ls : CommandCommon
  \../classes/log.ls
}
add = {log, database} |> require \../functions/add.ls

module.exports = class CommandAdd extends CommandCommon
  command: "add <names...>"
  description: "Add task."
  alias: \a
  options:
    * ["-s, --start", "With start."]
    ...
  action: (names, {start}:options) ->
    <- database.migrate
    names
    |> map (name) -> {name, start}
    |> each add
