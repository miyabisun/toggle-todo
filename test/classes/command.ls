require! {
  chai: {expect}
  \../../classes/command.ls : Command
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect Command .to.be.a \function
