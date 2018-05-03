require! {
  chai: {expect}
  proxyquire
  \../../classes/tasks.ls : Tasks
}
command = proxyquire \../../commands/remove.ls, {\../modules/log.ls : output: ->}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect command .to.be.a \function

  describe \remove, ->
    path = "#{__dirname}/../../tmp/test.yml"

    before-each ->>
      try await Tasks.remove path
      (tasks = Tasks.load path)
        ..add name: \hoge, status: \new
        ..add name: \piko, status: \doing
        ..add name: \fuga, status: \done
        ..save!

    specify "done items", ->
      command [], {end: yes, refresh: no}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 2

    specify "done items (with refresh)", ->
      command [], {end: yes, refresh: yes}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 2

    specify "id", ->
      command [1, 3], {end: no, refresh: no}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 1

    specify "id (with refresh)", ->
      command [1, 3], {end: no, refresh: yes}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 1
