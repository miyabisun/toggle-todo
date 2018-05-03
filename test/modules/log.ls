require! {
  chai: {expect}
  \../../modules/log.ls : log
  \../../classes/log.ls : Log
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect log .to.be.an.instanceof Log
