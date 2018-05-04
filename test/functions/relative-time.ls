require! {
  chai: {expect}
  luxon: {DateTime}
  \javascript-time-ago : TimeAgo
  \javascript-time-ago/locale/ja
  \../../src/functions/relative-time.ls
}
TimeAgo.locale ja
main = relative-time new TimeAgo \ja

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect main .to.be.a \function

  describe \time, ->
    specify \seconds, ->
      DateTime.local!.minus seconds: 30
      |> main >> expect >> (.to.be.a \string .that.equal "今")
    specify \minutes, ->
      DateTime.local!.minus minutes: 2
      |> main >> expect >> (.to.be.a \string .that.equal "2 分前")
    specify \hours, ->
      DateTime.local!.minus hours: 3
      |> main >> expect >> (.to.be.a \string .that.equal "3 時間前")
    specify \days, ->
      DateTime.local!.minus days: 3
      |> main >> expect >> (.to.be.a \string .that.equal "3 日前")
    specify \months, ->
      DateTime.local!.minus months: 3
      |> main >> expect >> (.to.be.a \string .that.equal "3 か月前")
    specify \years, ->
      DateTime.local!.minus years: 3
      |> main >> expect >> (.to.be.a \string .that.equal "3 年前")
