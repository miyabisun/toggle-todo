require! <[fs async]>
sqlite3 = require \sqlite3 .verbose!

module.exports = new class database
  ->
    @db = new sqlite3.Database "#{process.env.HOME}/.todo"
  needed_tables: (cb)->
    fs.readdir-sync "#__dirname/../tables/"
    |> filter (is /\.sql$/)
    |> map (.match /(.*)\.sql$/) >> (.1)
  has_tables: (cb)->
    err, rows <~ @db.all "select name from sqlite_master where type = 'table'"
    rows |> map (.name) |> cb
  create_table: (name, cb)->
    "#__dirname/../tables/#name.sql"
    |> fs.read-file-sync >> (.to-string!)
    |> @db.run _, cb
  migrate: (cb)->
    tables <~ @has_tables
    @needed_tables!
    |> difference _, tables
    |> async.each _, ((name, next)~> @create_table name, next), cb

