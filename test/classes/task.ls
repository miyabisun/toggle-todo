require! {
  chai: {expect}
  luxon: {DateTime}
  ramda: R
  \prelude-ls : P
  \../../src/classes/task.ls : Task
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect Task .to.be.a \function
    specify "instance is Task", ->
      Task.from {} |> expect >> (.to.be.an.instanceof Task)

  describe "properties (empty object)", ->
    task = Task.from {}
    [
      * \id, 1
      * \name, ""
      * \status, \new
      * \isStarted, no
      * \isEnded, no
    ].for-each ([name, val]) ->
      specify name, ->
        expect task.(name) .to.equal val
    <[modified created]>.for-each (name) ->
      specify name, ->
        expect task.(name) .to.be.an.instanceof DateTime

  describe \properties, ->
    data =
      id: 1
      name: \create-item
      status: \doing
      created: DateTime.local!.toISO!
      modified: DateTime.local!.toISO!
    task = Task.from data
    data |> R.to-pairs |> R.for-each ([key, val]) ->
      specify key, ->
        if key in <[created modified]>
          expect task.(key) .to.be.an.instanceof DateTime
        else
          expect task.(P.camelize key) .to.equal data.(key)
    specify \is-started, ->
      expect task.is-started .to.equal yes
    specify \is-ended, ->
      expect task.is-ended .to.equal no

  describe \methods, ->
    describe \update, ->
      modified = DateTime.from-millis 1525313922013
      task = Task.from do
        id: 1
        name: \create-item
        status: \new
        created: DateTime.local!.toISO!
        modified: modified.toISO!
      [
        * \id, 30
        * \name, \created-item
        * \status, \done
      ]
      |> R.tap R.from-pairs >> -> task.update it
      |> R.for-each ([key, val]) ->
        specify key, ->
          expect task.(key) .to.equal val
      specify \is-started, ->
        expect task.is-started .to.equal yes
      specify \is-ended, ->
        expect task.is-ended .to.equal yes
      specify \modified, ->
        expect DateTime.fromISO(task.modified).value-of! .to.be.above modified.value-of!
    [
      * \pause, \new
      * \do, \doing
      * \done, \done
    ].for-each ([type, status]) ->
      tasks =
        * Task.from id: 1, name: \hoge, status: \new
        * Task.from id: 2, name: \piko, status: \doing
        * Task.from id: 3, name: \fuga, status: \done
      tasks
      |> P.each (.(type)!)
      |> P.each (.status) >> expect >> (.to.equal status)
