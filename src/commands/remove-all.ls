require! <[fs]>
require! \../classes/command-common.ls

module.exports = class command-remove-all extends command-common
  command: "remove-all"
  description: "Remove todo-file at home directory."
  action: ->
    fs.unlink-sync "#{process.env.HOME}/.todo"
    console.log "Removed all tasks."

