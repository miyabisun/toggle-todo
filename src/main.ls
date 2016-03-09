global <<< require \prelude-ls
require! <[fs commander]>

err, files <- fs.readdir "#__dirname/commands"
files
|> filter -> it.match /.ls$/
|> each -> new (require "./commands/#it") commander

commander.parse process.argv
