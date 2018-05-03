require! {
  \../classes/command.ls : Common
  \../modules/log.ls : log
  \../modules/tasks.ls : load
}

module.exports = class Add extends Common
  command: "add <names...>"
  description: "Add task."
  alias: \a
  options:
    * "-s, --start", "With started."
    * "-e, --end", "With ended."
    ...
  action: (names, {start, end}:options, path) ->
    tasks = load path
    status =
      | end => \done
      | start => \doing
      | _ => \new
    names.for-each (name) ->
      {id} = tasks.add {name, status}
      log.output "[Add] #{id}: #{name} (#{status})}"
    tasks.save!
