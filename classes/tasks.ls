require! {
  fs, del
  \js-yaml : yaml
  ramda: R
  \./task.ls : Task
}

module.exports = class Tasks
  (@path, @tasks) ->
  @from = (path, tasks = []) -> new Tasks path, tasks
  @save = (path, tasks = []) -> fs.write-file-sync path, yaml.safe-dump tasks
  @load = (path) ->
    try
      seed = yaml.safe-load fs.read-file-sync path
      Tasks.from path, seed.map Task.from
    catch
      Tasks.save path; Tasks.load path
  @remove = (path) ->> del path

  new-id:~ -> @tasks.map (.id or 0) |> Math.max.apply(null, _) >> (or 0) >> (+ 1)
  asced:~ -> @tasks |> R.sort-by (.modified.value-of!)
  desced:~ -> @tasks |> R.sort-by (.modified.value-of!) |> R.reverse

  # methods
  find: (id) -> @tasks.find (.id is id)

  # bang methods
  add: (seed = {}) -> seed |> (<<< id: @new-id) |> Task.from |> R.tap ~> @tasks.push it
  remove: (id) -> @tasks = @tasks |> R.reject (.id is id)
  refresh: -> @tasks.for-each (task, i) -> task.id = i + 1
  save: -> Tasks.save @path, @tasks.map (.task)
