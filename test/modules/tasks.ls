require! {
  chai: {expect}
  \../../src/modules/tasks.ls : tasks
  \../../src/classes/tasks.ls : Tasks
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect tasks .to.be.a \function
    specify "return is Tasks instance", ->
      expect tasks! .to.be.an.instanceof Tasks
