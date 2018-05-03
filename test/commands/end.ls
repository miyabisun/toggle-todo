require! {
  chai: {expect}
  \../../classes/tasks.ls : Tasks
  \../../commands/end.ls : Main
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect Main .to.be.a \function

  describe.skip \end, ->
    path = "#{__dirname}/../../tmp/test.yml"
    command = new Main!

    before-each ->>
      try await Tasks.remove path
      (tasks = Tasks.load path)
        ..add name: \hoge, status: \new
        ..add name: \piko, status: \doing
        ..add name: \fuga, status: \done
        ..save!

    specify "one item (not start)", ->>
      command.action [1], void, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.0.name .to.equal \hoge
      expect tasks.tasks.0.status .to.equal \done

    specify "one item (started)", ->>
      command.action [2], void, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.1.name .to.equal \piko
      expect tasks.tasks.1.status .to.equal \done

    specify "one item (ended)", ->>
      command.action [3], void, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.2.name .to.equal \fuga
      expect tasks.tasks.2.status .to.equal \done

    specify "some items", ->>
      command.action [1, 2, 3], void, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
