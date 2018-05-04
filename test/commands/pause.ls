require! {
  chai: {expect}
  \../../src/classes/tasks.ls : Tasks
  \../../src/commands/pause.ls : command
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect command .to.be.a \function

  describe \pause, ->
    path = "#{__dirname}/../../tmp/test.json"

    before-each ->>
      try await Tasks.remove path
      (tasks = Tasks.load path)
        ..add name: \hoge, status: \new
        ..add name: \piko, status: \doing
        ..add name: \fuga, status: \done
        ..save!

    specify "one item (not stated)", ->
      command ids: <[1]>, {all: no}, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.0.status .to.equal \new

    specify "one item (started)", ->
      command ids: <[2]>, {all: no}, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.1.status .to.equal \new

    specify "one item (ended)", ->
      command ids: <[3]>, {all: no}, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.2.status .to.equal \new

    specify "some items", ->
      command ids: <[1, 2, 3]>, {all: no}, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3

    specify "all stated tasks", ->
      command ids: [], {all: yes}, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.0.status .to.equal \new
      expect tasks.tasks.1.status .to.equal \new
