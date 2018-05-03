require! {
  \prelude-ls : {filter}
}

module.exports = class Log
  (@list = []) ->
  @from = -> new Log it
  output: (log) ->
    @list ++ [log]
    console.log log
  filter: (word) -> @list |> filter (.match word)
  filter-prefix: (word) -> @list |> filter (is RegExp "/^#word/")
  filter-suffix: (word) -> @list |> filter (is RegExp "/#{word}$/")
