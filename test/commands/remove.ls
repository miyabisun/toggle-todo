require! {
  chai: {expect}
  \../../src/classes/tasks.ls : Tasks
  \../../src/commands/remove.ls : command
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect command .to.be.a \function

  describe \remove, ->
    path = "#{__dirname}/../../tmp/test.json"

    before-each ->>
      try await Tasks.remove path
      (tasks = Tasks.load path)
        ..add name: \hoge, status: \new
        ..add name: \piko, status: \doing
        ..add name: \fuga, status: \done
        ..save!

    specify "done items", ->
      command ids: [], {end: yes, refresh: no}, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 2

    specify "done items (with refresh)", ->
      command ids: [], {end: yes, refresh: yes}, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 2

    specify "id", ->
      command ids: <[1 3]>, {end: no, refresh: no}, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 1

    specify "id (with refresh)", ->
      command ids: <[1 3]>, {end: no, refresh: yes}, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 1
