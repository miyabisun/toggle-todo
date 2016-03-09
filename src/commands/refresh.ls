require! <[
  ../classes/command-common.ls
  ../classes/database.ls
  ../functions/refresh.ls
  ../functions/list.ls
]>

module.exports = class command-refresh extends command-common
  command: "refresh"
  description: "Refresh all tasks id."
  action: ->
    <- database.migrate
    refresh!
    list!

