require! \../classes/command-common.ls

module.exports = class ping extends command-common
  version: \1.0.0
  command: "ping"
  description: "response pong!"
  action: ->
    console.log "pong"
