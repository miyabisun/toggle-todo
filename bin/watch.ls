require! {
  fs, path
  \fs-readdir-recursive : readdir
  child_process: {spawn}
  \prelude-ls : P
}
output = (command) -> new Promise (resolve) ->
  console.info "> #{command}"
  command.split " " |> ->
    spawn it.0, it.slice 1
      ..stdout.pipe process.stdout
      ..stderr.pipe process.stderr
      ..on \close -> resolve yes
lint = (...files) ->> await output "ls-lint #{files.join " "}"
test = (file) ->> await output "mocha --colors #{file}"
hr = -> console.info "---------- ---------- ----------"

readdir "#{__dirname}/../src", (isnt \.)
|> P.map path.dirname
|> P.unique
|> P.each (dir) ->
  <[src test]>.for-each (parent-dir) ->
    tasks = new Set!
    fs.watch "#{parent-dir}/#{dir}", (type, file) ->>
      return if type isnt \change
      return if file isnt /\.ls$/
      return if tasks.has file
      tasks.add file
      try
        await lint "src/#{dir}/#{file}", "test/#{dir}/#{file}"
        await test "test/#{dir}/#{file}"
        hr!
      tasks.delete file

console.info "Get Ready."
hr!
