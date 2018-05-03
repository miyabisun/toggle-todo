require! {
  chai: {expect}
  \../../classes/tasks.ls : Tasks
  \../../commands/rename.ls : command
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect command .to.be.a \function

  describe \rename, ->
    path = "#{__dirname}/../../tmp/test.yml"

    before-each ->>
      try await Tasks.remove path
      (tasks = Tasks.load path)
        ..add name: \hoge, status: \new
        ..add name: \piko, status: \doing
        ..add name: \fuga, status: \done
        ..save!

    specify "successful", ->
      command {id: \1, name: \foo}, void, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.0.name .to.equal \foo

    specify "failed (equal)", ->
      command {id: \2, name: \piko}, void, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
      expect tasks.tasks.1.name .to.equal \piko

    specify "failed (notfound)", ->
      command {id: \5, name: \foo}, void, {info: ->}, path
      tasks = Tasks.load path
      expect tasks.tasks .to.be.an \array .that.be.length-of 3
