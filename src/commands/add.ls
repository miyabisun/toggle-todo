require! {
  \../modules/tasks : load
}

module.exports = ({names}:args, {start, end}:options, log, path) ->
  tasks = load path
  status =
    | end => \done
    | start => \doing
    | _ => \new
  names.for-each (name) ->
    {id} = tasks.add {name, status}
    log.info "[Add] #{id}: #{name} (#{status})}"
  tasks.save!
