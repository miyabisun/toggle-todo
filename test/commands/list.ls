require! {
  chai: {expect}
  \../../src/classes/tasks.ls : Tasks
  \../../src/classes/task.ls : Task
  \../../src/commands/list.ls : command
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect command .to.be.a \function

  describe \list, ->
    path = "#{__dirname}/../../tmp/test.json"

    before-each ->>
      try await Tasks.remove path
      (tasks = Tasks.load path)
        ..add name: \hoge, status: \new
        ..add name: \piko, status: \doing
        ..add name: \fuga, status: \done
        ..save!

    specify "successful (long)", ->
      log = []
      command [], {long: yes}, {info: -> log.push it}, path
      expect log.0 .to.be.match /Done/
      expect log.1 .to.be.match /fuga/
      expect log.2 .to.be.match /ToDo/
      expect log.3 .to.be.match /hoge/
      expect log.4 .to.be.match /Doing/
      expect log.5 .to.be.match /piko/

    specify "successful (short)", ->
      log = []
      command [], {long: no}, {info: -> log.push it}, path
      expect log.0 .to.be.match /done.*fuga/
      expect log.1 .to.be.match /todo.*hoge/
      expect log.2 .to.be.match /doing.*piko/
