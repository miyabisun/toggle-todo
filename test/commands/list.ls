require! {
  chai: {expect}
  \../../src/classes/tasks.ls : Tasks
  \../../src/classes/task.ls : Task
  \../../src/commands/list.ls : command
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect command .to.be.a \function

  describe \list, ->
    path = "#{__dirname}/../../tmp/test.yml"

    before-each ->>
      try await Tasks.remove path
      (tasks = Tasks.load path)
        ..add name: \hoge, status: \new
        ..add name: \piko, status: \doing
        ..add name: \fuga, status: \done
        ..save!

    specify "successful (long)", ->
      command [], {short: no}, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3

    specify "successful (short)", ->
      command [], {short: yes}, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
