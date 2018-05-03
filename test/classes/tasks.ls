require! {
  chai: {expect}
  fs
  \js-yaml : yaml
  \../../classes/tasks.ls : Tasks
  \../../classes/task.ls : Task
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect Tasks .to.be.a \function
    specify "instance is Tasks", ->
      Tasks.from "test" |> expect >> (.to.be.an.instanceof Tasks)

  describe \properties, ->
    tasks = Tasks.from "test", [Task.from(name: \hoge), Task.from(name: \piko)]
    specify \tasks, ->
      expect tasks.tasks .to.be.an \array .that.be.length-of 2
      expect tasks.tasks.0.name .to.equal \hoge
    specify \asced, ->
      expect tasks.asced .to.be.an \array .that.be.length-of 2
      expect tasks.asced.0.name .to.equal \hoge
    specify \desced, ->
      expect tasks.desced .to.be.an \array .that.be.length-of 2
      expect tasks.desced.0.name .to.equal \piko

  describe \methods, ->
    specify \find, ->
      tasks = Tasks.from "test", [Task.from(id: 123, name: \hoge), Task.from(id: 234, name: \piko)]
      expect tasks.find(123)?.name .to.equal \hoge
    specify \add, ->
      tasks = Tasks.from "test", [Task.from(id: 123, name: \hoge), Task.from(id: 234, name: \piko)]
      task = tasks.add name: \fuga
      expect tasks.tasks .to.be.length-of 3
      expect task.id .to.equal 235
      expect task.name .to.equal \fuga
    specify \remove, ->
      tasks = Tasks.from "test", [Task.from(id: 123, name: \hoge), Task.from(id: 234, name: \piko)]
      tasks.remove 234
      expect tasks.tasks .to.be.length-of 1
    specify \refresh, ->
      tasks = Tasks.from "test", [Task.from(id: 123, name: \hoge), Task.from(id: 234, name: \piko)]
      tasks.refresh!
      expect tasks.tasks.map (.id) .to.deep.equal [1, 2]

  describe \save, ->
    path = "#{__dirname}/../../tmp/test.yml"
    specify "remove -> load -> save -> load", ->>
      try await Tasks.remove path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.empty
      tasks.add name: \hoge
      expect tasks.tasks .to.be.an \array .that.be.length-of 1
      tasks.save!
      tasks2 = Tasks.load path
      expect tasks2.tasks .to.be.an \array .that.be.length-of 1
