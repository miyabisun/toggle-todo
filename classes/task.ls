require! {
  ramda: R
  luxon: {DateTime}
}

columns = <[id name status created modified]>
module.exports = class Task
  (@task) -> columns.for-each ~> @[it] = @[it]
  @from = (it = {}) -> new Task it
  id:~
    -> @task.id
    (val) -> @task.id = parse-int val or 1
  name:~
    -> @task.name
    (val) -> @task.name = val or ""
  status:~
    -> @task.status
    (val) -> @task.status = val or \new
  is-started:~ -> @status in <[doing done]>
  is-ended:~ -> @status is \done
  created:~
    -> DateTime.fromISO (@task.created or DateTime.local!.toISO!)
    (time) -> @task.created = time.toISO!
  modified:~
    -> DateTime.fromISO (@task.modified or DateTime.local!.toISO!)
    (time) -> @task.modified = time.toISO!
  value-of: -> @task
  update: (values = {}) ->
    (values <<< modified: DateTime.local!)
    |> R.to-pairs |> R.for-each ([key, val]) ~> @[key] = val
