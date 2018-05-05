require! {
  chai: {expect}
  \../../src/classes/tasks.ls : Tasks
  \../../src/commands/done.ls : command
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect command .to.be.a \function

  describe \end, ->
    path = "#{__dirname}/../../tmp/test.json"

    before-each ->>
      try await Tasks.remove path
      (tasks = Tasks.load path)
        ..add name: \hoge, status: \new
        ..add name: \piko, status: \doing
        ..add name: \fuga, status: \done
        ..save!

    specify "doing -> done", ->
      command void, void, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.1.name .to.equal \piko
      expect tasks.tasks.1.status .to.equal \done

    specify "doing -> new -> done", ->
      for _ in [1 to 2]
        command void, void, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.0.name .to.equal \hoge
      expect tasks.tasks.0.status .to.equal \done
