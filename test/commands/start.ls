require! {
  chai: {expect}
  \../../src/classes/tasks.ls : Tasks
  \../../src/commands/start.ls : command
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect command .to.be.a \function

  describe \start, ->
    path = "#{__dirname}/../../tmp/test.json"

    before-each ->>
      try await Tasks.remove path
      (tasks = Tasks.load path)
        ..add name: \hoge, status: \new
        ..add name: \piko, status: \doing
        ..add name: \fuga, status: \done
        ..save!

    specify "one item (not start)", ->
      command ids: <[1]>, void, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.0.name .to.equal \hoge
      expect tasks.tasks.0.status .to.equal \doing

    specify "one item (started)", ->
      command ids: <[2]>, void, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.1.name .to.equal \piko
      expect tasks.tasks.1.status .to.equal \doing

    specify "one item (ended)", ->
      command ids: <[3]>, void, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.2.name .to.equal \fuga
      expect tasks.tasks.2.status .to.equal \doing

    specify "some items", ->
      command ids: <[1 2 3]>, void, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
