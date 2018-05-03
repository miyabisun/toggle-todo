require! {
  chai: {expect}
  proxyquire
  \../../classes/tasks.ls : Tasks
  \../../classes/task.ls : Task
}
command = proxyquire \../../commands/next.ls, {\../modules/log.ls : output: ->}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect command .to.be.a \function

  describe \next, ->
    path = "#{__dirname}/../../tmp/test.yml"

    before-each ->>
      try await Tasks.remove path
      (tasks = Tasks.load path)
        ..add name: \hoge, status: \new
        ..add name: \piko, status: \doing
        ..add name: \fuga, status: \done
        ..save!

    specify "successful", ->
      command void, void, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
