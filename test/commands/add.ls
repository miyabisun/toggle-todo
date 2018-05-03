require! {
  chai: {expect}
  \../../classes/tasks.ls : Tasks
  \../../commands/add.ls : Main
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect Main .to.be.a \function

  describe.skip \add, ->
    path = "#{__dirname}/../../tmp/test.yml"
    command = new Main!
    specify "one item (not start)", ->>
      try await Tasks.remove path
      command.action <[hoge]>, {start: no, end: no}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 1
      expect tasks.tasks.0.name .to.equal \hoge
      expect tasks.tasks.0.status .to.equal \new

    specify "one item (started)", ->>
      try await Tasks.remove path
      command.action <[hoge]>, {start: yes, end: no}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 1
      expect tasks.tasks.0.name .to.equal \hoge
      expect tasks.tasks.0.status .to.equal \doing

    specify "one item (ended)", ->>
      try await Tasks.remove path
      command.action <[hoge]>, {start: no, end: yes}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 1
      expect tasks.tasks.0.name .to.equal \hoge
      expect tasks.tasks.0.status .to.equal \done

    specify "some items", ->>
      try await Tasks.remove path
      command.action <[hoge piko fuga]>, {start: yes, end: no}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.0.name .to.equal \hoge
      expect tasks.tasks.0.status .to.equal \doing
