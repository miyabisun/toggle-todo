global <<< require \prelude-ls
require! <[fs commander]>

"#__dirname/commands"
|> fs.readdir-sync
|> filter (is /.ls$/)
|> each -> new (require "./commands/#it") commander

process.argv.2 = \list unless process.argv.2?
commander.parse process.argv

