require! <[
  ../classes/command-common.ls
  ../classes/log.ls
  ../functions/database.ls
]>
remove = {log, database} |> require \../functions/remove.ls
refresh = {log, database} |> require \../functions/refresh.ls

module.exports = class command-remove extends command-common
  command: "remove [ids...]"
  description: "Remove task from list."
  alias: \rm
  options:
    * ["-e, --end", "Delete all ended tasks."]
    * ["-r, --refresh", "Refresh all tasks after delete."]
    ...
  action: (ids, {end, refresh}:options)->
    <~ database.migrate
    switch
    | end =>
      err, targets <- database.db.all """
        SELECT *
        FROM todo
        WHERE is_ended = 1
      """
      if empty targets => console.log "[Remove] not found task."; return
      targets |> each (.id) >> remove
    | ids? => that |> each remove
    | _ => console.log "[Remove] required id or end-option."
    process.on \beforeExec, refresh! if refresh

