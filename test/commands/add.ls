require! {
  chai: {expect}
  proxyquire
  \../../classes/tasks.ls : Tasks
}
command = proxyquire \../../commands/add.ls, {\../modules/log.ls : output: ->}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect command .to.be.a \function

  describe \add, ->
    path = "#{__dirname}/../../tmp/test.yml"

    before-each ->>
      try await Tasks.remove path

    specify "one item (not start)", ->
      command <[hoge]>, {start: no, end: no}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 1
      expect tasks.tasks.0.name .to.equal \hoge
      expect tasks.tasks.0.status .to.equal \new

    specify "one item (started)", ->
      command <[hoge]>, {start: yes, end: no}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 1
      expect tasks.tasks.0.name .to.equal \hoge
      expect tasks.tasks.0.status .to.equal \doing

    specify "one item (ended)", ->
      command <[hoge]>, {start: no, end: yes}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 1
      expect tasks.tasks.0.name .to.equal \hoge
      expect tasks.tasks.0.status .to.equal \done

    specify "some items", ->
      command <[hoge piko fuga]>, {start: yes, end: no}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.0.name .to.equal \hoge
      expect tasks.tasks.0.status .to.equal \doing
