require! {
  chai: {expect}
  \../../src/classes/tasks.ls : Tasks
  \../../src/commands/add.ls : command
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect command .to.be.a \function

  describe \add, ->
    path = "#{__dirname}/../../tmp/test.json"

    before-each ->>
      try await Tasks.remove path

    specify "one item (not start)", ->
      command names: <[hoge]>, {start: no, end: no}, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 1
      expect tasks.tasks.0.name .to.equal \hoge
      expect tasks.tasks.0.status .to.equal \new

    specify "one item (started)", ->
      command names: <[hoge]>, {start: yes, end: no}, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 1
      expect tasks.tasks.0.name .to.equal \hoge
      expect tasks.tasks.0.status .to.equal \doing

    specify "one item (ended)", ->
      command names: <[hoge]>, {start: no, end: yes}, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 1
      expect tasks.tasks.0.name .to.equal \hoge
      expect tasks.tasks.0.status .to.equal \done

    specify "some items", ->
      command names: <[hoge piko fuga]>, {start: yes, end: no}, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.0.name .to.equal \hoge
      expect tasks.tasks.0.status .to.equal \doing
