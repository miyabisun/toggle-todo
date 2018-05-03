require! {
  chai: {expect}
  \../../functions/to-int.ls : main
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect main .to.be.a \function

  describe \to-int, ->
    <[1 5 10 15 20]>.for-each (target) ->
      specify "#{JSON.stringify target} to number", ->
        expect main(target) .to.be.a \number .that.equal parse-int target
