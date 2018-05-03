require! {
  chai: {expect}
  \../../classes/tasks.ls : Tasks
  \../../classes/task.ls : Task
  \../../commands/refresh.ls : command
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect command .to.be.a \function

  describe \refresh, ->
    path = "#{__dirname}/../../tmp/test.yml"

    before-each ->>
      try await Tasks.remove path
      (tasks = Tasks.load path)
        ..tasks = [
          Task.from id: 123, name: \hoge, status: \new
          Task.from id: 234, name: \piko, status: \doing
          Task.from id: 345, name: \fuga, status: \done
        ]
        ..save!

    specify "successful", ->
      command void, void, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.0.id .to.equal 1
      expect tasks.tasks.1.id .to.equal 2
      expect tasks.tasks.2.id .to.equal 3
