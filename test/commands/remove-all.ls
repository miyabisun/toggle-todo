require! {
  chai: {expect}
  \../../src/classes/tasks.ls : Tasks
  \../../src/commands/remove-all.ls : command
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect command .to.be.ok

  describe \remove-all, ->
    path = "#{__dirname}/../../tmp/test.yml"

    before-each ->>
      try await Tasks.remove path
      (tasks = Tasks.load path)
        ..add name: \hoge, status: \new
        ..add name: \piko, status: \doing
        ..add name: \fuga, status: \done
        ..save!

    specify "successful", ->>
      await command void, void, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.empty
