require! {
  chai: {expect}
  proxyquire
  \../../classes/tasks.ls : Tasks
}
command = proxyquire \../../commands/pause.ls, {\../modules/log.ls : output: ->}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect command .to.be.a \function

  describe \pause, ->
    path = "#{__dirname}/../../tmp/test.yml"

    before-each ->>
      try await Tasks.remove path
      (tasks = Tasks.load path)
        ..add name: \hoge, status: \new
        ..add name: \piko, status: \doing
        ..add name: \fuga, status: \done
        ..save!

    specify "one item (not stated)", ->
      command [1], {all: no}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.0.status .to.equal \new

    specify "one item (started)", ->
      command [2], {all: no}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.1.status .to.equal \new

    specify "one item (ended)", ->
      command [3], {all: no}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.2.status .to.equal \new

    specify "some items", ->
      command [1, 2, 3], {all: no}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3

    specify "all stated tasks", ->
      command [], {all: yes}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.0.status .to.equal \new
      expect tasks.tasks.1.status .to.equal \new
