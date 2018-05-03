require! {
  chai: {expect}
  \../../classes/tasks.ls : Tasks
  \../../classes/task.ls : Task
  \../../commands/next.ls : Main
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect Main .to.be.a \function

  describe.skip \next, ->
    path = "#{__dirname}/../../tmp/test.yml"
    command = new Main!

    before-each ->>
      try await Tasks.remove path
      (tasks = Tasks.load path)
        ..add name: \hoge, status: \new
        ..add name: \piko, status: \doing
        ..add name: \fuga, status: \done
        ..save!

    specify "successful", ->
      command.action void, void, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
