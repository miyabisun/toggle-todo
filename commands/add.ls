require! {
  \../modules/log.ls : log
  \../modules/tasks.ls : load
}

module.exports = (names, {start, end}:options, path) ->
  tasks = load path
  status =
    | end => \done
    | start => \doing
    | _ => \new
  names.for-each (name) ->
    {id} = tasks.add {name, status}
    log.output "[Add] #{id}: #{name} (#{status})}"
  tasks.save!
