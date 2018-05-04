require! {
  fs, path
  del: {sync: del}
  livescript: LiveScript
  \js-yaml : yaml
  \mkdir-recursive : {mkdirSync: mkdir}
  \fs-readdir-recursive : read
  \prelude-ls : P
}

del ["#{__dirname}/../dist"]
[
  * filter: (is /\.ls$/)
    ext-from: \.ls
    ext-to: \.js
    compile: LiveScript.compile _, {bare: yes, const: yes}
  * filter: (is /\.yml$/)
    ext-from: \.yml
    ext-to: \.json
    compile: (yaml.safe-load _) >> (JSON.stringify _, null, 2)
].for-each (opt) ->
  read "#{__dirname}/../src"
  |> P.filter opt.filter
  |> P.each ->
    src = path.normalize "#{__dirname}/../src/#{it}"
    dist = path.normalize "#{__dirname}/../dist/#{it}"
      |> -> "#{path.dirname it}/#{path.basename it, opt.ext-from}#{opt.ext-to}"
    mkdir path.dirname dist
    fs.read-file-sync src .to-string!
    |> opt.compile
    |> fs.write-file-sync dist, _
    console.log "#{dist}"
