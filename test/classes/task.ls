require! {
  chai: {expect}
  luxon: {DateTime}
  ramda: R
  \prelude-ls : P
  \../../classes/task.ls : Task
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect Task .to.be.a \function
    specify "instance is Task", ->
      Task.from {} |> expect >> (.to.be.an.instanceof Task)

  describe \properties, ->
    data =
      id: 1
      name: \create-item
      is_started: no
      is_ended: no
      created: DateTime.local!.toISO!
      modified: DateTime.local!.toISO!
    task = Task.from data
    data |> R.to-pairs |> R.for-each ([key, val]) ->
      specify key, ->
        if key in <[created modified]>
          expect task.(key) .to.be.an.instanceof DateTime
        else
          expect task.(P.camelize key) .to.equal data.(key)

  describe \methods, ->
    describe \update, ->
      modified = DateTime.from-millis 1525313922013
      task = Task.from do
        id: 1
        name: \create-item
        is_started: no
        is_ended: no
        created: DateTime.local!.toISO!
        modified: modified.toISO!
      [
        * \id, 30
        * \name, \created-item
        * \isStarted, yes
        * \isEnded, yes
      ]
      |> R.tap R.from-pairs >> -> task.update it
      |> R.for-each ([key, val]) ->
        specify key, ->
          expect task.(key) .to.equal val
      specify \modified, ->
        expect DateTime.fromISO(task.modified).value-of! .to.be.above modified.value-of!
