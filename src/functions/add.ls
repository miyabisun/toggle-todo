require! <[moment]>
require! <[
  ../classes/database.ls
]>

module.exports = ({name, start})->
  now = moment!.format \X
  is_started = if start then 1 else 0
  err, id <- database.db.run """
    INSERT INTO todo(name, is_started, created, modified)
    VALUES($name, $is_started, $created, $modified)
  """, {$name: name, $is_started: is_started, $created: now, $modified: now}
  console.log "[Add] #{@lastID}: #{name}#{if start then " (start)" else ""}"

