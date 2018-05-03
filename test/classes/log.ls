require! {
  chai: {expect}
  \../../classes/log.ls : Log
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect Log .to.be.a \function
    specify "instance is Log", ->
      Log.from [] |> expect >> (.to.be.an.instanceof Log)
