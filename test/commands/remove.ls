require! {
  chai: {expect}
  \../../classes/tasks.ls : Tasks
  \../../commands/remove.ls : Main
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect Main .to.be.a \function

  describe.skip \remove, ->
    path = "#{__dirname}/../../tmp/test.yml"
    command = new Main!

    before-each ->>
      try await Tasks.remove path
      (tasks = Tasks.load path)
        ..add name: \hoge, status: \new
        ..add name: \piko, status: \doing
        ..add name: \fuga, status: \done
        ..save!

    specify "done items", ->
      command.action [], {end: yes, refresh: no}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 2

    specify "done items (with refresh)", ->
      command.action [], {end: yes, refresh: yes}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 2

    specify "id", ->
      command.action [1, 3], {end: no, refresh: no}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 1

    specify "id (with refresh)", ->
      command.action [1, 3], {end: no, refresh: yes}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 1
