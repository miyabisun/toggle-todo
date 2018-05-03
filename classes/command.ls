require! {
  \prelude-ls : {is-type, each, apply}
}

module.exports = class Command
  (@program) !->
    return unless @program
    set = ~>
      return unless @.(it)?
      switch
      | it |> is-type \Array => @program = @.(it) |> apply @program~(it)
      | _ => @program = @program.(it) @.(it)
    <[version command alias]> |> each set
    if @options? then that |> each ~> @program = it |> apply @program~option
    <[description action]> |> each set
