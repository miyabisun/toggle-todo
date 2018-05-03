{filter} = require \prelude-ls

module.exports = new class log
  -> @list = []
  output: (log)->
    @list ++ [log]
    console.log log
  filter: (word)-> @list |> filter (.match word)
  filter-prefix: (word)-> @list |> filter (is RegExp "/^#word/")
  filter-suffix: (word)-> @list |> filter (is RegExp "/#{word}$/")

