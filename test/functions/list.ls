require! {
  chai: {expect}
  luxon: {DateTime}
  \../../classes/task.ls : Task
  \../../functions/list.ls : main
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect main .to.be.a \function

  describe "output test", ->
    specify "all empty", ->
      result = []
      main (output: -> result.push it), []
      expect result .to.be.length-of 0

    [
      * \new, "ToDo."
      * \doing, "Doing tasks."
      * \done, "Done tasks."
    ].for-each ([status, title]) ->
      specify "#{status} task only", ->
        result = []
        tasks = [
          Task.from name: \taro, status: status
          Task.from name: \jiro, status: status
        ]
        main (output: -> result.push it), tasks
        expect result .to.be.length-of 3
        expect result.0 .to.equal title

    specify "has all task", ->
      result = []
      tasks = [
        Task.from name: \taro, status: \new
        Task.from name: \jiro, status: \doing
        Task.from name: \saburo, status: \done
        Task.from name: \siro, status: \done
        Task.from name: \goro, status: \doing
        Task.from name: \mutsugoro, status: \new
      ]
      main (output: -> result.push it), tasks
      expect result .to.be.length-of 3 + 6
      expect result.0 .to.equal "Done tasks."
      expect result.3 .to.equal "ToDo."
      expect result.6 .to.equal "Doing tasks."
