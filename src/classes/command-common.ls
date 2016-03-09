module.exports = class command-common
  (@program)!->
    <[version command description action]>
    |> each ~>
      if @.(it)? then @program = @program?.(it) that
